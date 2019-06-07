s.boot;

s.meter;
s.plotTree;
s.quit;


/////Tempo
(
t = TempoClock(124/60).permanent_(true);
t.schedAbs(t.nextBar, {t.beats.postln;1});
)

t.schedAbs(t.nextBar,{t.tempo_(120/60);nil});

t.stop

//////files in folders

(
d = Dictionary.new;
PathName("/Users/bazili/Desktop/DPMS/SC SOUNDS/").entries.do{
	arg subfolder;
	d.add(
		subfolder.folderName.asSymbol ->
		Array.fill(
			subfolder.entries.size,
			{
				arg i;
				Buffer.read(s, subfolder.entries[i].fullPath);
			}
		);
	);
};
)
d.class;
d.size;






/////////TANZ RHINO 500\\\\\\\\






                    /////KickDrum\\\\\



Env([0,1,0], [1, 1], [1, -1]).plot;

(
SynthDef.new(\KickDrum,
{
      arg freqA=500, freqB=50, freqC=10, freqDur1=0.01, freqDur2=0.2, freqCurv1=1, freqCurv2=1, attk=0.01, rel=1, curv1=1, curv2=(-12), amp=1, pan=0, out=0;
      var sig, env, freqSweep;

      freqSweep = Env([freqA, freqB, freqC], [freqDur1, freqDur2], [freqCurv1, freqCurv2]).ar;
      env = Env([0, 1, 0], [attk, rel], [curv1, curv2]).kr(2);
	  sig = SinOsc.ar(freqSweep, pi/2);
	  sig = sig * env;
	  sig = Pan2.ar(sig, pan, amp);
	  Out.ar(out, sig)
}).add
)


x = Synth.new(\KickDrum, [\freqA, 300, \attk, 0.2, \rel, 1, \amp,1]);

//Envelope Graph
Env([500, 50, 10], [0.01, 0.2], [1, -1]).plot;
Env([0, 1 ,0], [0.01, 1], [1, -12]).plot;


(
Pbindef(\kickDrum,
	\instrument, \KickDrum,
	\dur, 1,
	\amp, 1,
	\freqA, 500,
	\attk, 0.01,
	\rel, 0.2,
	\out, 0
).play(t, quant: 4);
)



                      //////Snare\\\\\\



~snare = Buffer.read(s, "/Users/bazili/Library/Application Support/SuperCollider/Snare Carabooboo 1.wav");
~snare.play;


(
SynthDef.new(\snare, {
	arg attk=0.01, rel=1, c1=1, c2=(-1), amp=1, buf, out=0;
	var  sig, env;
	env = Env([0, 1, 0], [attk, rel], [c1, c2]).kr(2);
	sig = PlayBuf.ar(2, buf);
	sig = sig*env;
	Out.ar(out, sig)
}).add;
)

y = Synth.new(\snare, [\buf, ~snare]);


(
Pbindef(\snare,
	\instrument, \snare,
	\buf, ~snare,
	\dur, 2,//Pseq([0,0.5,0.75,0],inf),//Pseq([0,1,0,1],2),
	\amp, 0.1,
	\attk, 0.04,
	\rel, 1,
	\out, 0
).play(t,quant: 2);
)



                        /////HIHAT\\\\\


  
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


(
Pbindef(\hihat,
	\instrument, \hihat,
	\buf, ~hihat,
	\dur,Pseq([0,0.5,0.75,0],inf),//Pseq([0,1,0,1],2),
	\amp,0.1,
	\attk, 0.06,
	\rel, 1,
	\out, 0
).play(t, quant: 4);
)


/////COWBELL\\\\\


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
Pbindef(\cowbell,
	\instrument, \cowbell,
	\buf, ~cowbell,
	\dur, Pseq([0,0,0.25,0,0,],1),
	\amp,1,
	\attk, 0.01,
	\rel, 1,
	\out, 0
).play(t, quant: 4);
)

)



        ///////// Random Drums \\\\\\\\\\\

(
SynthDef.new(\randpercs, {
	arg attk=0.01, rel=1, c1=1, c2=(-1), amp=1, buf=0, out=0;
	var  sig, env;
	env = Env([0, 1, 0], [attk, rel], [c1, c2]).kr(2);
	sig = PlayBuf.ar(2, buf);
	sig = sig*env;
	Out.ar(out, sig)
}).add;
)
(
~sounds = Pbind(
	\instrument, \sounds
	\buf, Prand(d[\africa],inf),
	\dur, Pseq([3,1,0.25,0.25,0.5,1],2),
	\attk, 0.01,
	\rel, 1,
	\amp, 1,
	\out, 0
).play(t, quant: 2);
)
~sounds.stop;
~sounds.play;
(
Pbindef(\myRandpercs,
	\instrument, \randpercs,
	\buf, Prand(d[\africa],inf),
	\dur,Pseq([0.25, 0.25, 1, 0.5, 0.5, 1, 0.25, 0.25],inf), //Pseq([ 0.5, 0.5, 0.25, 0.25, 1, 0.25, 1, 0.25],inf),
	\amp, 1,
	\attk, 0.01,
	\rel, 1,
	\out, 0
).play(t, quant:4);
)




                    ////START STOP CONTROLS\\\\\\


Pdef(\kickDrum).play(t);
Pdef(\kickDrum).stop;

Pdef(\snare).play(t);
Pdef(\snare).stop;

Pdef(\hihat).play(t);
Pdef(\hihat).stop;

Pdef(\cowbell).play(t);
Pdef(\cowbell).stop;

Pdef(\Randpercs).play(t);
Pdef(\Randpercs).free;
t.stop;











////////SYNTH NOT READY YET. HOLD YOUR BREATH NOW CAUSE IT'S COMMING...\\\\\\\\\\\\\











//////SYNTH V1\\\\\\\

(
SynthDef.new(\pulseTest, {
	arg ampHz=4, fund=40, maxPartial=4, width=0.5;
	var amp1, amp2, sig1, sig2, freq1, freq2;
	amp1 = LFPulse.kr(ampHz,0,0.12) * 0.75;
	amp2 = LFPulse.kr(ampHz,0.5,0.12) * 0.75;
	freq1 = LFNoise0.kr(4).exprange(fund, fund * maxPartial).round(fund);
	freq2 = LFNoise0.kr(4).exprange(fund, fund * maxPartial).round(fund);
	freq1 = freq1 * (LFPulse.kr(8)+1);
	freq2 = freq2 * (LFPulse.kr(6)+1);
	sig1 = Pulse.ar(freq1, width, amp1);
	sig2 = Pulse.ar(freq2, width, amp2);
	sig1 = FreeVerb.ar(sig1, 0.7, 0.8, 0.25);
	sig2 = FreeVerb.ar(sig2, 0.7, 0.8, 0.25);
	Out.ar(0, sig1);
	Out.ar(1, sig2);
}).play;
)

)
(
Pbindef(\pulseTest,
	\instrument, \pulseTest,
	\dur,Pseq([1],1),
	\amp, 1,
	\attk, 0.01,
	\rel, 1,
	\out, 0
).play(t, quant:4);
)

x = Synth.new(\pulseTest);
x.set(\width, 0.5);
x.set(\width, 0.25);
x.set(\fund, 70);
x.set(\fund, 670);
x.free


///////SYNTH V2\\\\\\\



(
x = {
    MoogFF.ar(
        Pulse.ar([40,121], [0.3,0.5]),
		SinOsc.ar(XLine.kr(2000, 200), 0, 0.5) )}.play;
)
x.free;





play{x=SinOsc;y=LFNoise0;a=y.ar(8);(x.ar(Pulse.ar(1)*24)+x.ar(90+(a*90))+MoogFF.ar(Saw.ar(y.ar(4,333,666)),a*XLine.ar(1,39,99,99,0,2)))!2/3}

play{VarSaw.ar((Hasher.ar(Latch.ar(SinOsc.ar((1..4)!2),Impulse.ar([5/2,5])))*300+300).round(60),0,LFNoise2.ar(2,1/3,1/2))/5}
{Splay.ar(Ringz.ar(Impulse.ar([2, 1, 4], [0.1, 0.11, 0.12]), [0.1, 0.1, 0.5])) * EnvGen.kr(Env([1, 1, 0], [120, 10]), doneAction: 2)}.free;
