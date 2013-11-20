// Assignment_3_Invading_Barbarians
<<<"Assignment_3_Invading_Barbarians">>>;

// PLEASE READ HERE BEFORE PLAYING:
// Note that I used Math.fmod() instead of % because my counter variable is (now-start)/second, id est a float variable. But the trick is the same
// I suppose a Noise to be considered an oscillator!
// I used .25s as well as multiples as clarified to be allowed by the staff through the forum
// At the end, closed to the dead line, I discovered some issues, so the last hours were very hard.. I end up as good as I could but the commenting is not so clear as it should.. I apologize, I'm very sorry!
// thanks =) Hope you like it

1 => dac.gain; // use this first line to control the total gain, if it is anomalous on your device (it is ok on mine) change 1 with a smoller number

now=>time start;
100::samp=>dur step;

//Starting noise
SinOsc n1 => Pan2 p1 => dac;
SinOsc n2 => Pan2 p2 => dac;


// variables for the invading barbarians
.4=>float ibgain;
10=>int C1;
Math.srandom(3551); // 551 ,  5771  ,
0=>int onetime;

[38,40,41,43,45,47,48,50,52,53,55,57,59,60,62,64,65,67,69,71,72,74] @=> int mdorian[];
float fdorian[mdorian.cap()];
for (0=>int i; i<mdorian.cap(); ++i) Std.mtof(mdorian[i])/Std.mtof(50) => fdorian[i];

Gain smaster => dac;
0=>smaster.gain;
SndBuf sbufib[C1];
for (0=>int i; i<C1; ++i) sbufib[i]=>smaster;

[me.dir() + "/audio/clap_01.wav",
 me.dir() + "/audio/click_02.wav",
 me.dir() + "/audio/click_05.wav",
 me.dir() + "/audio/cowbell_01.wav",
 me.dir() + "/audio/hihat_04.wav",
 me.dir() + "/audio/kick_04.wav",
 me.dir() + "/audio/kick_05.wav",
 me.dir() + "/audio/snare_02.wav",
 me.dir() + "/audio/stereo_fx_04.wav",
 me.dir() + "/audio/stereo_fx_04.wav"] @=> string sfileib[];
for (0=>int i; i<C1; ++i) sfileib[i]=>sbufib[i].read;

int iib[C1];
int grainlength[C1];
int graincenter[C1];
float grainrate[C1];
int grainduration[C1];

for (0=>int j; j<C1;++j) {
0=> iib[j];
0=> grainlength[j];
0=> graincenter[j];
0=> grainrate[j];
0=> grainduration[j];
}


//variables for the kick breathing

6=> int C;
.6=>float kbgain;
Gain breath[C];
SndBuf sbuf[C];
Pan2 span[C];
for (0=>int j;j<C;++j) { sbuf[j]=>breath[j]=>span[j]=>dac; 0=>sbuf[j].gain; .5=>breath[j].gain;}

0=>int cnt;
[.5,1,2]@=>float rap[];

[ me.dir() + "/audio/hihat_04.wav" ,
  me.dir() + "/audio/kick_05.wav"  ,
  me.dir() + "/audio/hihat_04.wav" ,
  me.dir() + "/audio/kick_05.wav"  ,
  me.dir() + "/audio/hihat_04.wav" ,
  me.dir() + "/audio/kick_05.wav" ] @=> string sfile[];
for (0=>int j;j<C;++j) sfile[j]=>sbuf[j].read;
[sbuf[0].samples()-1,0,
 sbuf[0].samples()-1,0,
 sbuf[0].samples()-1,0]@=>int spos1[];
[-1.671*rap[0],1.671*rap[0],
 -1.671*rap[1],1.671*rap[1],
 -1.671*rap[2],1.671*rap[2]]@=>float srate1[];
[1.671*rap[0],-1.671*rap[0],
 1.671*rap[1],-1.671*rap[1],
 1.671*rap[2],-1.671*rap[2]]@=>float srate2[];
[(2/rap[0])::second,(2/rap[0])::second,
 (2/rap[1])::second,(2/rap[1])::second,
 (2/rap[2])::second,(2/rap[2])::second]@=>dur speriod[];
[speriod[0]/2.0,speriod[1]/2.0,speriod[2]/2.0,speriod[3]/2.0,speriod[4]/2.0,speriod[5]/2.0]@=>dur sstart2[];
[1::second,1::second,
 0::second,0::second,
 .5::second,.5::second]@=>dur sdelay[]; // must be < period

[.25,.2,.15,.05,.1,.005]@=>float sgain[];

[0,0,0,0,0,0]@=> int i[];
[0,0,0,0,0,0]@=> int k[];
for (0=>int j; j<C;++j) 0=>sbuf[j].gain;
for (0=>int j; j<C;++j) -.8 + j/3.0 => span[j].pan;


//variables for the singing voices

4=> int Cv;
Pan2 voicepan[Cv];
0.15=> float voicegain;
SndBuf voicebuf[Cv];

[me.dir() + "/audio/stereo_fx_05.wav",
 me.dir() + "/audio/stereo_fx_05.wav",
 me.dir() + "/audio/stereo_fx_05.wav",
 me.dir() + "/audio/stereo_fx_05.wav" ] @=> string files[];

for (0=>int j; j<Cv; ++j) {
    voicebuf[j]=>voicepan[j]=>dac;
    files[j]=>voicebuf[j].read;
    (j+8)*voicebuf[j].samples()/20 =>voicebuf[j].pos;
    0=>voicebuf[j].gain;
    -1 + 2*(j%2) =>voicepan[j].pan;
}

[0,0,62,64,65,60,59,67,72,74,0,64,65,69,74,72,64,65,62,0,0] @=> int v1note[]; 
[2.0,.75*2,.1875*2,.0625*2,.25*2,.5*2,.625*2,.0625*2,.0625*2,1.5*2,.625*2,.0625*2,.0625*2,.1875*2,.0625*2,.25*2,.5*2,.75*2,1.5*2,15] @=> float v1dur[];
float v1time[v1dur.cap()+1]; 0=>v1time[0];
for (1=>int j; j<v1time.cap(); ++j) v1time[j-1] + v1dur[j-1] => v1time[j];
[0,0,0,0] @=>int v1cnt[];

[0.0,0  ,.12,.2,.6 ,.5,.3 ,0.0,.3*.7,.2*.6,.6*.5 ,.4*.3,.1*.2 ,0 ,0] @=> float gp1height[]; // ----->  ha un elemento in più rispetto a dur, che mettiamo a 0 per ora
[2.0,1.0*2,.25*2,.5*2,.75*2,1*2 ,.5*2,1.0*2,.25*2,.5*2,.75*2,1*2 ,.5*2,15] @=> float gp1dur[];
float gp1time[gp1dur.cap() +1]; 0=>gp1time[0];
for (1=>int j; j<gp1time.cap(); ++j) gp1time[j-1] + gp1dur[j-1] => gp1time[j];
[0,0,0,0] @=>int gp1cnt[];

// Main Loop (creating the time)


while ((now-start)/second < 30) {
    
    //      code for the starting signal
    
    if ((now-start)/second <1) {
    -1*(now-start)/3::second => p1.pan;
    1 *(now-start)/3::second =>p2.pan;
    .1*Math.pow((now-start)/second ,2)  =>  n1.gain;
    .1*(now-start)/second  =>  n2.gain;
    (20 + 10000 * (now-start)/2::second )=> n1.freq;
    (20 + 10000 * (now-start)/2::second )+.1=>n2.freq;
    }
    if (((now-start)/second <2) && ((now-start)/second >1)) {
    -1* (now-start)/2::second => p1.pan;
    1 * (now-start)/2::second =>p2.pan;
    .1*(1-(now-start-1::second)/1::second)  =>  n1.gain;
    .1*(1-Math.pow((now-start-1::second)/1::second,2) )  =>  n2.gain;
    (20 + 10000 * (now-start)/2::second )=> n1.freq;
    (20 + 10000 * (now-start)/2::second )+.1=>n2.freq;
    }

    
    //      code for the invading barbarians
    

    for (0=>int j; j<C1;++j) {
        if (iib[j]==0)
        {
            Math.random2(1000,sbufib[j].samples()) => grainlength[j]; 
            Math.random2(grainlength[j]/2,sbufib[j].samples()- grainlength[j]/2) => graincenter[j];

            fdorian[Math.random2(0,fdorian.cap()-1)] * (-1 + 2*Math.random2(0,1)) => grainrate[j];
            grainrate[j]=> sbufib[j].rate;
            Std.ftoi(graincenter[j] - Math.sgn(grainrate[j])*grainlength[j]/2) => sbufib[j].pos;
            
            Std.ftoi(grainlength[j] / Math.fabs(grainrate[j])) => grainduration[j]; // qui c'è samples al posto di grainlength dando una pausa tra grani e maggior respiro
        }
        iib[j]+100=>iib[j];
        if (iib[j]>=grainduration[j]-1) 0=>iib[j];
        (-1*iib[j]*Math.sgn(iib[j]+.5- grainduration[j]/2) + grainduration[j]*(2*iib[j]/grainduration[j]) ) / (grainduration[j]/2.0) => sbufib[j].gain; // il .5 è fondamentalissimo
    }
    if ((now-start)/second>15) ibgain*Math.pow((now-start-15::second)/15::second,2) => smaster.gain;
    
   
    //      code for the kick breathing
    
    for (0=>int j; j<C;++j) {
        if (( Math.fmod((now-start-sdelay[j])/second,speriod[j]/second) < sstart2[j]/second )&&(Math.fmod((now-start-sdelay[j])/second,speriod[j]/second) > 0)&&(i[j]==0)) {
            srate1[j]=>sbuf[j].rate;
            if ( k[j] == 0) {
                spos1[j]=>sbuf[j].pos;
                } 
            ++i[j]; ++k[j];
        }
        
        if (( Math.fmod((now-start-sdelay[j])/second,speriod[j]/second) > sstart2[j]/second )&&(i[j]==1)) {
            srate2[j]=>sbuf[j].rate;
            0=>i[j]; ++k[j];
        }
    if (((now-start)/second > 2)&&((now-start)/second < 10)) kbgain*sgain[j] => sbuf[j].gain;
    else if ((now-start)/second <2) kbgain*sgain[j]*Math.pow((now-start)/2::second,5) => sbuf[j].gain;
    else if ((now-start)/second >10) kbgain*sgain[j]*(start+30::second-now)/20::second => sbuf[j].gain;
    }
    
    // code for the singing voices
    for (0=>int i;i<Cv ;++i) {
        for (0=>int j; j< v1note.cap(); ++j) {
            if ( (((now-start)/second)> v1time[j]+.08*(i%2)) && (v1cnt[i]==j) ){
                if (v1note[v1cnt[i]] > 0) {
                        if (voicebuf[i].rate() >=0) Std.mtof(v1note[v1cnt[i]])/Std.mtof(45 + 7*(i%2)) => voicebuf[i].rate;
                        else -Std.mtof(v1note[v1cnt[i]])/Std.mtof(45+7*(i%2)) => voicebuf[i].rate;
                }
                else 0=>voicebuf[i].rate;
                ++v1cnt[i];
            }
        }

        for (0=>int j; j< gp1height.cap(); ++j) {
            if ( (((now-start)/second)> gp1time[j]+.08*(i%2)) && (gp1cnt[i]==j) ){
                ++gp1cnt[i];
            }
        }
        
        if (gp1cnt[i]>=1) {
        voicegain*.5*(2-i%2)*(gp1height[gp1cnt[i]-1] + (gp1height[gp1cnt[i]] - gp1height[gp1cnt[i]-1])*(-gp1time[gp1cnt[i]-1]+(now-start)/second)/gp1dur[gp1cnt[i]-1]) => voicebuf[i].gain;  // linear interpolation between two subsequent gain heights
        }
        
        if (voicebuf[i].rate() ==0) 0=>voicebuf[i].gain;

        if (voicebuf[i].pos()> .65*voicebuf[i].samples()) -voicebuf[i].rate() => voicebuf[i].rate;
        if (voicebuf[i].pos()< .35*voicebuf[i].samples()) -voicebuf[i].rate() => voicebuf[i].rate;

        (-1 + 2*(i%2))* (1-(((now-start)/second)/30)) =>voicepan[i].pan;
    }
    // time step
    
    step=>now;      
}

1=>dac.gain;
