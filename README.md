# Sonarts_2019-DrumMachine-


s.boot;

s.meter;
s.plotTree;
s.quit;


/////Tempo
(
t = TempoClock(60/60).permanent_(true);
t.schedAbs(t.nextBar, {t.beats.postln;1});
)

t.schedAbs(t.nextBar,{t.tempo_(120/60);nil});

t.stop


//////DRUMMACHINE500\\\\\\\\

///KickDrum

Env([0,1,0], [1, 1], [1, -1]).plot;

(
SynthDef.new(\KickDrum,
{
      arg freqA=1000, freqB=50, freqC=10, freqDur1=0.01, freqDur2=0.2, freqCurv1=1, freqCurv2=1, attk=0.01, rel=1, curv1=1, curv2=(-12), amp=0.7, pan=0, out=0;
      var sig, env, freqSweep;

      freqSweep = Env([freqA, freqB, freqC], [freqDur1, freqDur2], [freqCurv1, freqCurv2]).ar;
      env = Env([0, 1, 0], [attk, rel], [curv1, curv2]).kr(2);
	  sig = SinOsc.ar(freqSweep, pi/2);
	  sig = sig * env;
	  sig = Pan2.ar(sig, pan, amp);
	  Out.ar(out, sig)
}).add
)


x = Synth.new(\KickDrum, [\freqA, 500, \attk, 0.01, \rel, 1, \amp,1]);

//Envelope Graph
Env([500, 50, 10], [0.01, 0.2], [1, -1]).plot;
Env([0, 1 ,0], [0.01, 1], [1, -12]).plot;



//Play in sequence (60 by defult,[dur 1])
(
x = Pbind(
	\instrument, \KickDrum,
	\dur,1,//add seq.. Pseq([1,1,0.25,0.25,0.5,1],inf)
	\attk, 0.01,
	\rel, 1,
	\amp, 1, //add vel.. Pwhite(0.1,1,inf),
	\out, 0
).play
)

x.stop

//Pbinddef *not working yet*

(
Pbindef(\kickDrum,
	\instrument, \KickDrum,
	\dur, 1,
	\amp, 1,
	\freqA, 500,
	\attk, 0.01,
	\rel, 0.2,
	\out, 0
).play(t);
)


//////////Snare

~snare = Buffer.read(s, "/Users/bazili/Library/Application Support/SuperCollider/Snare Carabooboo 1.wav");
~snare.play


(
SynthDef.new(\snare, {
	arg attk=0.01, rel=1, c1=1, c2=(-1), amp=1, buf, out=0;
	var  sig, env;
	env = Env([0, 1, 0], [attk, rel], [c1, c2]).kr(2);
	sig = PlayBuf.ar(2, buf);
	sig = sig*env;
	Out.ar(out, sig)
}).add
)

y = Synth.new(\snare, [\buf, ~snare]);


(
y = Pbind(
	\instrument, \snare,
	\dur,1,/////add seq.. Pseq([1,1,0.25,0.25,0.5,1],inf)
	\attk, 0.01,
	\rel, 1,
	\amp, 1,/////add vel.. Pwhite(0.1,1,inf),
	\out, 0
).play
)

y.stop;

)


/////////HIHAT


~hihat = Buffer.read(s, "/Users/bazili/Library/Application Support/SuperCollider/ClosedHH Decadence 1.wav");
~hihat.play

(
SynthDef.new(\hihat, {
	arg attk=0.01, rel=1, c1=1, c2=(-1), amp=1, buf, out=0;
	var  sig, env;
	env = Env([0, 1, 0], [attk, rel], [c1, c2]).kr(2);
	sig = PlayBuf.ar(2, buf);
	sig = sig*env;
	Out.ar(out, sig)
}).add
)


h = Synth.new(\hihat, [\buf, ~hihat]);

/////COWBELL

~cowbell = Buffer.read(s, "/Users/bazili/Library/Application Support/SuperCollider/Cowbell Aviator.wav");
~cowbell.play

(
SynthDef.new(\cowbell, {
	arg attk=0.01, rel=1, c1=1, c2=(-1), amp=1, buf, out=0;
	var  sig, env;
	env = Env([0, 1, 0], [attk, rel], [c1, c2]).kr(2);
	sig = PlayBuf.ar(2, buf);
	sig = sig*env;
	Out.ar(out, sig)
}).add
)


c = Synth.new(\cowbell, [\buf, ~cowbell]);

(
c = Pbind(
	\instrument, \cowbell
	\dur,1,
	\attk, 0.01,
	\rel, 1,
	\amp, 1,
	\out, 0
).play
)

c.stop;

)
