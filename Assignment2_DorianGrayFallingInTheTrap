// Assignment_2_Dorian_Gray_Falling_In_The_Trap

// PLEASE READ HERE BEFORE PLAYING!! THANKS
// Last time some reviewer experienced too loud volume on my assingnment, eventhough it was all right on other devices
// It meas the total gain is device-dependent
// this first instruction control the total gain, please adjust it if you have too much or less sound
.5=>dac.gain; // please replace with ".1=>dac.gain;" if you hear too much, or with "1=>dac.gain;" if you don't hear enough

// Note also that despite I fixed the random seed, someone reported device-dependent random numbers even within fixed seeds
// So I'm not sure you're hearing the same as mine.
// If necessary I posted the exported wav file on https://soundcloud.com/prossimamente/assignment-2-dorian-gray

// this script has two simultaneous parts, a melody with some armonic background, and some noise imitating the sound of insects

5::ms=>dur step; // time step the melody
.005=>float dt; //  time step for the bees

// MELODY variables

[1.0,2,3,5,7,8,9,11] @=> float ratio[]; // setting the harmonics I want, you get the frequencies multiplying by the note frequency
.5=> float delta; // a parameter to increase the damping
.01=> float attac; // a parameter that control the attac of each sound 
0=> float ifl; // a float to store (as a float) the int value of i 

now=>time start; 

// here the midi notes for the 5 voices, the durations, and the volume

[[57,50,57,50, 60,52,60,52, 57,52,57,52, 59,50,59,50
 ,65,59,65,59, 69,60,69,60, 71,62,71,62, 67,59,67,59
 ,65,55,65,55, 62,53,62,53, 64,55,64,55, 62,52,62,52
 ,60,52,60,52, 62,55,62,55, 0,0,0,0, 0,0,0,0
 ,0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
 ,0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
 ,0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]
 
,[52,45,52,45,52,45,52,45, 53,47,53,47,53,47,53,47, 50,45,50,45,50,45,50,45, 52,47,52,47,52,47,52,47
 ,60,53,60,53,60,53,60,53, 62,55,62,55,62,55,62,55, 64,57,64,57,64,57,64,57, 60,55,60,55,60,55,60,55
 ,57,53,57,53,57,53,57,53, 55,50,55,50,55,50,55,50, 57,52,57,52,57,52,57,52, 55,50,55,50,55,50,55,50
 ,53,50,53,50,53,50,53,50, 53,50,53,50,53,50,53,50]
 
,[41,36,40,43,41,47,52,45, 41,38,43,36,41,41,0,0, 0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0]
 
,[33,28,31,35,33,38,43,36, 33,29,35,28,33,33,0,0, 0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0]
 
,[26,21,24,28,26,31,36,21, 26,23,28,21,26,26,0,0, 0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0]] @=> int note[][];

[[.5,.5,.5,.5,.5,.5,.5,.5,  .5,.5,.5,.5,.5,.5,.5,.5
 ,.5,.5,.5,.5,.5,.5,.5,.5,  .5,.5,.5,.5,.5,.5,.5,.5
 ,.5,.5,.5,.5,.5,.5,.5,.5,  .5,.5,.5,.5,.5,.5,.5,.5
 ,.5,.5,.5,.5,.5,.5,.5,.5,   0,0,0,0, 0,0,0,0
 ,0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
 ,0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
 ,0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]
 
,[.25,.25,.25,.25,.25,.25,.25,.25, .25,.25,.25,.25,.25,.25,.25,.25, .25,.25,.25,.25,.25,.25,.25,.25, .25,.25,.25,.25,.25,.25,.25,.25
 ,.25,.25,.25,.25,.25,.25,.25,.25, .25,.25,.25,.25,.25,.25,.25,.25, .25,.25,.25,.25,.25,.25,.25,.25, .25,.25,.25,.25,.25,.25,.25,.25
 ,.25,.25,.25,.25,.25,.25,.25,.25, .25,.25,.25,.25,.25,.25,.25,.25, .25,.25,.25,.25,.25,.25,.25,.25, .25,.25,.25,.25,.25,.25,.25,.25
 ,.25,.25,.25,.25,.25,.25,.25,.25, .25,.25,.25,.25,.25,.25,.25,.25]
 
,[2.0,2,2,2,2,2,2,2,  2,2,2,2,4,2,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0]
 
,[2.0,2,2,2,2,2,2,2,  2,2,2,2,4,2,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0]
 
,[2.0,2,2,2,2,2,2,2,  2,2,2,2,4,4,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0]] @=> float dnote[][];

[[.01,.005,.007,.005,.011,.005,.006,.005,  .01,.005,.007,.005,.006,.005,.007,.005,  .011,.006,.008,.006,.012,.007,.009,.006,  .011,.005,.008,.005,.006,.005,.007,.005
 ,.01,.005,.007,.005,.011,.005,.006,.005,  .01,.005,.007,.005,.006,.005,.007,.005,  .01,.005,.007,.005,.011,.005,.006,.005,  .01,.005,.007,.005,.006,.005,.007,.005
 ,.01,.005,.007,.005,.011,.005,.006,.005,  .01,.005,.007,.005,.006,.005,.007,.005,  .01,.005,.007,.005,.011,.005,.006,.005,  .01,.005,.007,.005,.006,.005,.007,.005
 ,.01,.005,.007,.005,.006,.005,.005,.005]
 
,[.008,.003,.005,.003,.004,.003,.003,.003, .008,.003,.005,.003,.004,.003,.003,.003, .008,.003,.005,.003,.004,.003,.003,.003, .008,.003,.005,.003,.004,.003,.003,.003
 ,.008,.003,.005,.003,.004,.003,.003,.003, .008,.003,.005,.003,.004,.003,.003,.003, .008,.003,.005,.003,.004,.003,.003,.003, .008,.003,.005,.003,.004,.003,.003,.003
 ,.008,.003,.005,.003,.004,.003,.003,.003, .008,.003,.005,.003,.004,.003,.003,.003, .008,.003,.005,.003,.004,.003,.003,.003, .008,.003,.005,.003,.004,.003,.003,.003
 ,.008,.003,.005,.003,.004,.003,.003,.003, .008,.003,.005,.003,.004,.003,.003,.003]
 
,[.003,.003,.003,.003,.003,.003,.003,.003,  .003,.003,.003,.003,.003,.003,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0]
,[.003,.003,.003,.003,.003,.003,.003,.003,  .003,.003,.003,.003,.003,.003,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0]
,[.01,.008,.009,.008,.011,.012,.011,.008,  .009,.008,.009,.008,.012,.01,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 ,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0]] @=> float vnote[][];


float snote[note.cap()][note[0].cap()]; // time for each note to start
.15=>snote[0][0];                       // here I set a delay different for each voice, to have the "arpeggio" effect
.1=>snote[1][0];
0.1=>snote[2][0];
0.05=>snote[3][0];
0=>snote[4][0];

for (0=> int j; j<note.cap(); ++j) for (1=>int i; i< snote[0].cap(); ++i) {snote[j][i-1]+dnote[j][i-1]=>snote[j][i];}

SinOsc harm[note.cap()][ratio.cap()]; //sound network

float temp[note.cap()][note[0].cap()];  // temporary time variables, each starts by 0 every time a new note comes up
for (0=>int j; j<note.cap(); ++j) for (0=>int i; i<ratio.cap(); ++i) {harm[j][i] => dac; 0=>harm[j][i].gain;} //some initialization
for (0=>int j; j<note.cap(); ++j) for (0=>int i; i<note[0].cap(); ++i) 0=>temp[j][i];

// BEES variables

Math.srandom(3367);
10 => int C; //number of bees
SawOsc s[C]; // Oscillators and Pans for each bee
Pan2 p[C];
for ( 0 => int i ; i< C ; ++i ) s[i] => p[i] => dac;

/* in a cartesian plain (x,y) you are at (0,y0) ; the bee is at (x0 + v*t , 0)
 v is the velocity of the bee with respect to its direction
 vs is the sound velocity
 vr is the relative velocity between you and the bee, mathematically computed
 g0 is the gain of the bee as measured locally (it is actually percepted divided by the distance)
 f0 is the frequency emitted by the bee as measured locally (it is actually percepted altered by the doppler effect)
 the pan position is mathematically computed as the actual angle for each bee
*/


float q[C];  /* variable giving the ratio between the frequencies percepted at the farest distancies */
340=>float vs;
500=>float xmax; // max value for x
20=>float ymax;
/* here some frequency, there's no serious reason for choosing them on the Dorian scale XD
 they could also be other frequencies or even randomly chosen each time
 but by fixing them there's a feeling of "structure" in the global sound */
[Std.mtof(45),Std.mtof(50),Std.mtof(57),Std.mtof(62)]@=>float Dorian[];
float px[C]; /* ratio between the velocity of each bee and the sound velocity */
float v[C];
float vr[C];
float y0[C];
float x0[C]; // starting position of each bee
float x[C];  // position of each bee
float f0[C]; 
float f[C];  // f is the percepted frequency for each bee
for ( 0 => int i ; i< C ; ++i )
{
    Math.random2(0,Dorian.cap()-1) => int j1; /* choosing a starting frequency for each bee */
    Math.random2(0,Dorian.cap()-1) => int j2; /* choosing an ending frequency for each bee */
    if (j2==j1 && j2 != 0) --j2; else if (j2==j1 && j2 == 0) ++j1;   // they must be different
    Dorian[j1]=>f0[i];
    f0[i]/Dorian[j2]=>q[i]; /* computing the ratio between the frequencies */
    (q[i]-1)/(q[i]+1) => px[i]; /* this is the needed rato for having the chosen frequencies */
    vs*px[i]=>v[i];
    Math.random2f(-ymax,ymax)=>y0[i]; /* choosing starting x0 and y0 in appropriate intervals */
    Math.random2f(-xmax,xmax)=>x0[i];
    x0[i]=>x[i];
}

0=>float t;     //initialize t and g0
0.15=>float g0;



//MAIN LOOP creating the time


while (now-start < 30::second) //to control the total lingth
{
    // Part giving the melody
    for (0=>int k;k<note.cap();++k) // k is the voice, j is the note, i is the harmonic
    for (0=>int j; j<note[0].cap(); ++j) if ( (now-start)/second > snote[k][j] && (now-start)/second < snote[k][j]+dnote[k][j]) // play the note if it is at time
    {
        for (0=> int i; i<ratio.cap(); i+1=>i)
        {
            i=>ifl; // I need i as a float
            2*Std.mtof(note[k][j])*ratio[i]=>harm[k][i].freq; // setting the harmonics
            vnote[k][j]/Math.pow(ifl+1+delta,.25*temp[k][j]*note[k][j]/7)=>harm[k][i].gain; // setting the gain of the harmonics to have a keybord inspired sound
            (.75- .25*Math.cos(2*pi*(now-start)/30::second))*harm[k][i].gain()=>harm[k][i].gain;
            if (temp[k][j]<attac*52/note[k][j]) (note[k][j]/(attac*52))*temp[k][j]* harm[k][i].gain()=>harm[k][i].gain; // attac
            if (temp[k][j]>.9*dnote[k][j]) (10*(dnote[k][j]-temp[k][j])/dnote[k][j]) * harm[k][i].gain()=>harm[k][i].gain; // damp
            if (temp[k][j]>.95*dnote[k][j]) 0=>harm[k][i].gain; // silent
        }
        temp[k][j]+step/second=>temp[k][j];
    }
    
    // Part giving the bees
    
    for ( 0 => int i ; i< C ; ++i )  // for each bee
    {
        x[i]+v[i]*dt=>x[i]; // update x
        if (Math.fabs(x[i])>=xmax) {x[i]+v[i]*t=>x0[i];-v[i]=>v[i];} /* invert the motion if too far */
        -v[i]*(x0[i]+v[i]*t)/Math.hypot(x[i],y0[i])=>vr[i]; /* this is the formula for relative velocity */

        f0[i]*vs/(vs-vr[i])=>f[i]; /* this is the doppler effect formula */
        
        f[i]=>s[i].freq;
        
        (.75+ .25*Math.cos(2*pi*(now-start)/30::second))*g0/Math.hypot(x[i],y0[i])=>s[i].gain; /* this is the distance attenuation of the gain formula */
        
        Math.atan(x[i]/y0[i])=>p[i].pan; /* pan in the actual angle of the car with respect of you  */
    }
    
    t+dt=>t;       // update t for the bees
    
    step=>now;
}

1=>dac.gain;

// Thanks, have a nice day.
