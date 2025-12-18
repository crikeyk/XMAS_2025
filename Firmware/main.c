#include "stm8s.h"
#include <stdlib.h>

#define NUM_LEDS       14
#define NUM_LEDS_HALF (NUM_LEDS / 2)
#define MAX_BRIGHTNESS 20
#define TIMEOUT_SECONDS 10  // PA1 pulled low after this many seconds

volatile bool change = TRUE;
volatile uint8_t lights[NUM_LEDS][3];
volatile uint8_t seconds_counter = 0;  // counts seconds for PA1 timeout

volatile bool timeout_active = FALSE;       // tracks if PA1 is currently low
volatile uint8_t timeout_hold_counter = 0;  // counts seconds PA1 stays low

#define TIMEOUT_HOLD        10   // keep PA1 low for 10 seconds

/* ---- BASIC DELAY ---- */
void delay_ms(uint16_t ms)
{
    uint16_t count = ms * 0.4;
    while(count--) { nop(); }
}

/* ---- WS2812 BIT-BANG ---- */
void ws_write_byte_top(uint8_t byte)
{
    uint8_t mask = 0x80;
    while(mask) {
        if(byte & mask) {
            _asm("bset 20495,#4");
            nop();nop();nop();nop();nop();nop();nop();nop();
            nop();nop();nop();nop();
            _asm("bres 20495,#4");
        } else {
            _asm("bset 20495,#4");
            nop();nop();nop();nop();nop();nop();
            _asm("bres 20495,#4");
            nop();nop();nop();
        }
        mask >>= 1;
    }
}

void ws_write_byte_bot(uint8_t byte)
{
    uint8_t mask = 0x80;
    while(mask) {
        if(byte & mask) {
            _asm("bset 20495,#5");
            nop();nop();nop();nop();nop();nop();nop();nop();
            nop();nop();nop();nop();
            _asm("bres 20495,#5");
        } else {
            _asm("bset 20495,#5");
            nop();nop();nop();nop();nop();nop();
            _asm("bres 20495,#5");
            nop();nop();nop();
        }
        mask >>= 1;
    }
}

static void ws_write_grb_top(uint8_t *c)
{
    ws_write_byte_top(c[0]);
    ws_write_byte_top(c[1]);
    ws_write_byte_top(c[2]);
}

static void ws_write_grb_bot(uint8_t *c)
{
    ws_write_byte_bot(c[0]);
    ws_write_byte_bot(c[1]);
    ws_write_byte_bot(c[2]);
}

/* ---- WRITE ENTIRE DISPLAY ---- */
void write_display(void)
{
    uint8_t i;

    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
    CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);

    for(i = 0; i < NUM_LEDS_HALF; i++)
        ws_write_grb_top(lights[i]);

    for(i = 0; i < NUM_LEDS_HALF; i++)
        ws_write_grb_bot(lights[i]);

    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
    CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV128);
}

/* ---- CLEAR ---- */
void clear_lights(void)
{
    uint8_t i;
    for(i=0;i<NUM_LEDS;i++)
        lights[i][0] = lights[i][1] = lights[i][2] = 0;
}

/* ---- LINEAR TRIANGLE SINE ---- */
uint8_t linearSine(uint8_t v)
{
    v &= 255;
    return (v < 128) ? v : (255 - v);
}

/* ---- DOWNWARD RAINBOW FADE ---- */
void downwardFade(void)
{
    uint8_t t = 0;
    uint8_t i, hue;
    uint8_t r, g, b;
    int startHue = rand() & 0xFF;

    change = FALSE;
    clear_lights();

    while(!change)
    {
				for(i = 0; i < NUM_LEDS; i++)

        {
            hue = (startHue + t + i*12) & 0xFF;

            if(hue < 85) {
                r = 255 - hue*3;
                g = hue*3;
                b = 0;
            } else if(hue < 170) {
                r = 0;
                g = 255 - (hue-85)*3;
                b = (hue-85)*3;
            } else {
                r = (hue-170)*3;
                g = 0;
                b = 255 - (hue-170)*3;
            }

            r = (r * MAX_BRIGHTNESS) / 255;
            g = (g * MAX_BRIGHTNESS) / 255;
            b = (b * MAX_BRIGHTNESS) / 255;

            lights[i][0] = r;
            lights[i][1] = g;
            lights[i][2] = b;
        }

        write_display();

        t -= 6;
        delay_ms(15);
    }
}

/* ---- TIM2 SETUP (1 Hz tick) ---- */
void init_tim2(void)
{
    TIM2->PSCR = 0x0E;     // prescaler ~16384
    TIM2->ARRH = 0x03;     // ARR = 31250 ? 1 Hz (approx)
    TIM2->ARRL = 0xD0;
    TIM2->IER  = 0x01;     // enable update interrupt
    TIM2->CR1 |= 0x01;     // start timer
}

/* ---- MAIN ---- */
int main(void)
{
    sim();
    CLK_DeInit();
    CLK_HSICmd(ENABLE);

    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
    CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV128);

    GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
    GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_LOW_FAST);

    GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_OUT_PP_HIGH_FAST); // PA1 starts high

    srand(1234); // fixed seed, or replace with ADC seeding

    clear_lights();
    init_tim2();
    rim();  // enable interrupts

    while(1)
        downwardFade();
}

/* ---- TIM2 INTERRUPT ---- */

@svlreg @far @interrupt void tim2Handler(void)
{
    TIM2->SR1 &= ~0x01;  // clear interrupt flag

    if(!timeout_active)
    {
        seconds_counter++;
        if(seconds_counter >= TIMEOUT_SECONDS)
        {
						clear_lights();
						write_display();

            GPIO_WriteLow(GPIOA, GPIO_PIN_1); // pull PA1 low
            timeout_active = TRUE;
            timeout_hold_counter = 0;
						
						delay_ms(2000);

        }
    }
    else
    {
        timeout_hold_counter++;
        if(timeout_hold_counter >= TIMEOUT_HOLD)
        {
            GPIO_WriteHigh(GPIOA, GPIO_PIN_1); // release PA1
            // optionally reset counters if you want repeated timeouts
            timeout_active = FALSE;
            seconds_counter = 0;
        }
    }
}
