// Assignment 4: The Tireless Mr SwingRobot Never Rests

// PLEASE USE THIS FIRST LINE OF CODE TO ADAPT THE VOLUME TO YOUR OWN DEVICE
0.2=> float overallgain;
overallgain=>dac.gain;
// reduce or incread the value(0.2) either if you want less or more sound

// This script is basically a random pattern generator; The patterns are not completely random, but cast into some probability distributions.
// I used this schema both for melodic and rythmic purposes.
// The heart of this script is this first function (ChoseI of ChoseF for int or float, it is basically the same function)

// As this is a generator it could go on forever, you can change this overall duration if you want to hear what happens later

60.0=> float overallduration; // in seconds


fun int ChoseI( int P[]) {   // will return an index i, having a probability proportional to P[i] to be chosen. NOT NORMALIZED
    
    int Sum[P.cap()]; P[0] => Sum[0];
    for (1=> int i; i<P.cap(); ++i) Sum[i-1] + P[i] => Sum[i];
    Math.random2(0,Sum[P.cap()-1])=> float Rand;
    0=>int i;
    while (Sum[i]<Rand) ++i; // Note that there's no "=", it's important
    return i;
}

fun int ChoseF( float P[]) {   // will return an index i, having a probability proportional to P[i] to be chosen. NOT NORMALIZED
    
    float Sum[P.cap()]; P[0] => Sum[0];
    for (1=> int i; i<P.cap(); ++i) Sum[i-1] + P[i] => Sum[i];
    Math.random2f(0,Sum[P.cap()-1])=> float Rand;
    0=>int i;
    while (Sum[i]<=Rand) ++i; // Note that there's the "=" here, it's important
    return i;
}

fun void CopyArray( int b[], int a[]) { // copies array b into array a
    for (0=>int i; i<a.cap(); ++i) b[i]=>a[i];
}

fun void PrintArray( int tobeprint[]) { // I used this just for debuging
    <<<"PrintArray">>>;
    for (0=>int i; i<tobeprint.cap(); ++i) <<<tobeprint[i]>>>;
}

fun int Max(int data[]) { // return the index corresponding to the highest value of the array.
                          // I know there are smarter algorithms for this purpose, but in this case the data aren't eavy that much
    0=> int max;
    for (0=>int k; k<data.cap()-1; ++k) {
        for (k+1=> int j; j<data.cap(); ++j) {
            if ((data[k]>=data[j])&&(data[k]>data[max])) k=>max;
            else if ((data[j]>data[k])&&(data[j]>data[max])) j=>max;
        }
    }
    return max;
}

// Here the probability distribution for the melodies,

[
// 1    (0)
[[5,3,7,4,6,2],
 [7,5,4,3,2,1]],
// 2    (1)
[[1,5,7,6,3,4],
 [7,5,4,3,2,1]],
// 3    (2)
[[1,5,7,4,2,6],
 [7,5,4,3,2,1]],
// 4    (3)
[[5,1,3,7,2,6],
 [7,5,4,3,2,1]],
// 5    (4)
[[1,4,3,7,6,2],
 [7,5,4,3,2,1]],
// 6    (5)
[[7,1,4,5,2,3],
 [7,5,4,3,2,1]],
// 7    (6)
[[5,6,3,2,4,1],
 [7,5,4,3,2,1]]

] @=> int prob[][][]; // indexes mean: prob[starting note (0-6) must add 1 each][(0) for the next notes array, (1) for the corresponding probability array][ index of the subsequent note]

// PAY ATTENTION: notes are positions on the mixolidian scale (every 1 is a diatonic step, it is not a midi semitone.. id est an octave is 7 steps, not 12)

[[1,1,0],[1,1,0],[1,1,0]] @=>int note[][]; // note[][0] is the fondamental bass (running on fifths progression), note[k][1] is the actual played note shifted in the central octave, note[k][2] is the octave of the actual note playing(-2,-1,0,1,2)
// the actual note is 21+ note[k][0]-1 +note[k][1]-1 +7*note[k][2] , the first index beeing the voice label

int nextnote[note.cap()][note[0].cap()]; // same for the next of the chain
for (0=>int k; k<note.cap(); ++k) CopyArray(note[k],nextnote[k]);
int octaves[5];  // to store the probabilities to chose an octave, I use the same for all the voices

// for choseing the next shifted note do:   prob[note[k][1]-1][0][Chose(prob[note[k][1]-1][1])] => nextnote[k][1]
// for choseing the most likely octave:
// have to chose an int between -2 and 2, most likely the next note to be as near as possible to the previous.
// distances are (i 0 to 4) Std.abs(nextnote[k][1]+7*(i-2) - note[k][1]+7*note[k][2]) ; (no need to subtract 1 because is a distance)
// I have to chose most likely the smoller, I take a probability of (35 - distance) (so should be always positive as greater as distance is smaller)
// id est the probability of choseing the value (i-2) for nextnote[2] 
// 35 - Std.abs( nextnote[k][1]+7*(i-2) - note[k][1]+7*note[k][2] ) => octaves[i];
// Max(octaves) -2 => nextnote[k][2]
// than copy nextnote[k] into note[k] and use it


now=>time start;
100::samp=>dur step;

[51, 53, 55, 56, 58, 60, 61]@=> int mixolidianoctave[];
int mixolidian[7*mixolidianoctave.cap()]; // here 7 is becose I want 7 octaves (I will use only 5 in the middle)
// here I set the miditones, so here an octave is 12 steps
for (0=>int n; n<mixolidian.cap(); ++n) mixolidianoctave[n%7] -36 + 12*(n/7) => mixolidian[n]; // mixolidian[24] will be 51 (to be verifyed) (here 7 is becose scale has 7 notes)
[Std.mtof(51),Std.mtof(51),Std.mtof(51)] @=> float rif[]; // right rif for the different samples to be fixed

// it shoud be that, when I change the note[0], the played note remains the same but note[1] is changed (as well as the probability distribution)

// the actual midi tone will be mixolidian[36+note[0]-1+note[1]-1+7*note[2]] (I subtract 1 becose I need just the distance)

[4,5,6,7,1,2,3] @=> int bassprog[];
[5,6,7,1,2,3,4] @=> int backprog[];

// I want the fondamental bass to be the same for all the singing voices
// when the bass is to be changed it takes the new value bassprog[note[0]] => note[0]
// then note[1] must change as well so that the actual played note remains the same, so backprog[note[1]] => note[1]


1=> int basschangecounter; // I first try to use the same for all the voices

Math.srandom(377); // 277, 377

// here the probability distribution for the rythmic pattern

[[[1.0  ,.5  ,.3334,1.5  ,2 ],          // first pattern
  [9.0  ,5   ,4    ,1    ,.5]],

 [[1.0  ,1.5 ,.75  ,2    ,4    ,.25],         // second pattern
  [8.0  ,5   ,5    ,2    ,.5   ,.5 ]]]@=> float tempo[][][];

[.3  , 1.2 , 2.4 , 2.4 , .3  , .6  ,.6 ] @=> float mainpulse[];
[0.2 , 0.2 , .1  , .2  , .2 , .15 ,.15 ] @=> float sbufgain[];
[.5  , .5  , 2   , 2   , 4   , 2   ,2   ] @=> float sbufrate[];
[-.2 , .2  , .4  , -.4 , -.3 , .3  ,0   ] @=> float sbufpan[];

mainpulse.cap()=>int C;
int duration[C];
int i[C];
0=> int ptr;

SndBuf sbuf[C];                         // inizializeing some variable for the soundbufs
Pan2 span[C];
[me.dir() + "/audio/hihat_04.wav",
 me.dir() + "/audio/kick_01.wav",
 me.dir() + "/audio/stereo_fx_01.wav",
 me.dir() + "/audio/cowbell_01.wav",
 me.dir() + "/audio/stereo_fx_05.wav",
 me.dir() + "/audio/stereo_fx_05.wav",
 me.dir() + "/audio/stereo_fx_05.wav" ] @=> string sfile[];

for (0=>int k;k<C ;++k) {
    sbuf[k]=>span[k]=>dac;
    sfile[k]=>sbuf[k].read;
    0=>sbuf[k].gain;
    0=> i[k];
    sbufpan[k] => span[k].pan;
}
0=>int CC; // a temp variable to gradually add voices

SinOsc s=>dac;    //just because it's required
440.0=>s.freq;
0=>s.gain;
0.0=>float gauss;
int onoff[note.cap()]; for (0=>int k; k<note.cap(); ++k) 0=>onoff[k];

while ((now-start)/second < overallduration) {
    
    ( ((now-start)/.6::second)$int % 16 )/8 => int ptr; // change rythmic pattern every period
    if (CC<C) 2+ ( ((now-start)/.6::second)$int % 64 )/2 => CC;
    for (0=>int k;k<CC ;++k) {
        if (i[k]==0) { // this fix the duration of a note for each voices, same method for all
            ((mainpulse[k] - Math.fmod((now-start)/second, mainpulse[k]) ) * tempo[ptr][0][ChoseF(tempo[ptr][1])] * 1::second/step )$int => duration[k]; // potrei porre un minimo durmin[] 
            0=>sbuf[k].pos;
            if (k>3) { //this block of code is for the singing voices
                // if (k==5) ++basschangecounter; // that could be placed better
                note[k-4][0]=>nextnote[k-4][0];
                prob[note[k-4][1]-1][0][ChoseI(prob[note[k-4][1]-1][1])] => nextnote[k-4][1];
                for (0=>int i;i<5 ;++i) 35 - Std.abs( nextnote[k-4][1]+7*(i-2) - note[k-4][1]-7*note[k-4][2] ) => octaves[i];
                Max(octaves) -2 => nextnote[k-4][2];
                if (nextnote[k-4][2]<1) nextnote[k-4][2]+ Math.random2(0,11)/10 => nextnote[k-4][2];
                CopyArray(nextnote[k-4],note[k-4]);

                
                Std.mtof(mixolidian[21+note[k-4][0]-1+note[k-4][1]-1+7*note[k-4][2]])/rif[k-4] => sbuf[k].rate;
   
            }
            else sbufrate[k]::second/ (step*duration[k]) => sbuf[k].rate;
        }
        
        if (i[k]<duration[k]) {
            sbufgain[k] * (duration[k] - i[k]) / duration[k]$float => sbuf[k].gain;
            ++i[k];
        }
        
        else 0=>i[k];
        
        // if (basschangecounter%16 == 0 ) {
        if ((k>3)&&( ((now-start)/.6::second)$int % 16 ==0 )&&(onoff[k-4]==0) ) {
            bassprog[note[k-4][0]-1]=> note[k-4][0]; <<<note[k-4][0],k>>>;
            backprog[note[k-4][1]-1]=> note[k-4][1];
            ++onoff[k-4];
        }
        if ((k>3)&&( ((now-start)/.6::second)$int % 16 ==1 )) 0=>onoff[k-4];

    }
    
    if ((now-start)/second > overallduration*5.0/6.0) 6*overallgain*(now-start-overallduration::second)/overallduration::second => dac.gain; //final cut
    
    0=>gauss;
    for (2=>int g; g<10; 4+g=>g) Math.exp(-1* Math.pow((now-start- g*4.8::second)/second ,2)/2.0) +gauss => gauss; // control the SinOsc gaussian picks
    0.005*gauss=>s.gain;
    
    step=>now;

    
}

1=> dac.gain;
