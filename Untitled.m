clear;
clc;

[x1, Fs1] = audioread('signal1.MP3');
[x2, Fs2] = audioread('signal2.MP3');
[x3, Fs3] = audioread('signal3.MP3');
%x: signal, FS: frequency

x1 = resample(x1(:,1),3,1); %take only 1 channel
x2 = resample(x2(:,1),3,1);
x3 = resample(x3(:,1),3,1);

%resample to inc. freq: if we've fs=10KHZ and we resample with 3 then 3*10KHZ

d=max([length(x1) length(x2) length(x3)]);

same_length=@(x, d) [x;zeros(d - length(x), 1)];

[x1, x2, x3]=deal(same_length(x1,d),same_length(x2,d), same_length(x3,d));

x=[x1,x2,x3];

fs = 3 * min([Fs1,Fs2,Fs3]);

%draw 3 original signals

signal_draw(x1, fs, strcat(' original 1'));
signal_draw(x2, fs, strcat(' original 2'));
signal_draw(x3, fs, strcat(' original 3'));



%modulation
BW=4*10^3;
fco=15*10^3;
%don't overlap
fc1=fco-2*BW;
fc2=fco+ 4*BW;
fc3=fco+ 11*BW;

ym= modulate(x1, fs, fc1) + modulate(x2, fs, fc2) + modulate(x3, fs, fc3);
signal_draw(ym, fs, ' modulated 3 signals');

%bpf
yb=[];
for fc=[fc1,fc2,fc3], yb=[yb, (bpf(ym,5,BW, fc,fs))'], end
%for ybx=yb, signal_draw(ybx,fs), end

%demodulation
yd=[];
fc=[fc1,fc2,fc3];
for i=1: length(fc), yd=[yd, (demodulate(yb(:,i), fs, fc(i), 0,0))'], 
end
for ydx=yd,signal_draw(ydx, fs, strcat(' demodulated ')) , end


%lpf
yf=[];
for ydx=yd, yf=[yf, (lpf(ydx', 5, BW, fs))'], end
%for yfx=yf, signal_draw(yfx, fs), end

%hear original signals
for i=1:3, sound(x(:,i), fs) ,
pause(25), %wait for previous sound to finish
end

%hear demodulated signals
for i=1:3 , sound(yf(:,i), fs), 
pause(25), %wait for previous sound to finish
end
%%%%%%%%%%%%%%%%%%%%%%
yd2=[];
phase=[deg2rad(10),deg2rad(30),deg2rad(90)];
for i=1:length(phase) , yd2=[yd2,(demodulate(yb(:,2), fs, fc(2), 0,phase(i)))'], end
yf2=[];
for ydx=yd2 ,yf2=[yf2,(lpf(ydx', 10, BW, fs))'], end
%%%hear signals
sound(x(:,2),fs);
for i=1:3 ,sound(yf2(:,i ),fs),pause(25),end
%%%%%%%%%%second signal frequency
yd2=[];
df=[2,10];
for i=1:length(df),yd2=[yd2,(demodulate(yb(:,2), fs, fc(2), 0,df(i)))'], end
yf2=[];
for ydx=yd2 ,yf2=[yf2,(lpf(ydx', 5, BW, fs))'], end
%%%hear signals

for i=1:2 ,sound(yf2(:,i ),fs),pause(25),end


%code will be repeated alot
function signal_draw(y , fs,name)
    
    n = length(y); %number of sampled points

    %Time domain
    t = linspace(0,n/fs , n); %the time space (x-axis)to get y steps
    figure; 
    plot(t,y); %get the signal in time domain
    title(strcat('Time Domain ',name));
    xlabel('Time');
    ylabel('Amplitude');

    %#Freq domain

    f = linspace(-fs/2,fs/2,n);  %#the freq space (centered around zero)
    Y = fft(y,n);
    %The output of the FFT is a complex vector containing information about the frequency content of the signal. 
    %The magnitude tells the strength of the frequency components relative to other components. 
    %The phase tells how all the frequency components align in time.

    %##Amplitude
    amp = abs(Y); %abs will get the amplitude of the complex vector
    figure;
    plot(f(1:n),amp(1:n));    
    title(strcat('Frequency Domain ',name));
    xlabel('Frequency');
    ylabel('Amplitude');

    %##Phase
    phase = angle(Y); %#angle gives the phase of the comlex vector
    figure;
    plot(f(1:n),phase(1:n));   
    title(strcat('Frequency Domain ',name));
    xlabel('Frequency');
    ylabel('Phase');
end

function ym=modulate(y,fs,fc)
    t=linspace(0,length(y)/fs, length(y)); %1 row
    ym= (y)' .* cos(2*pi*fc*t); % y' *Wc*t %y transpose to be 1 row
    %Wc must be > fc/2 to not overlap
end

function yd=demodulate(yb,fs, fc,df, dphi)
    t=linspace(0,length(yb)/fs, length(yb)); %1 row
    yd= (yb)' .* cos(2*pi*(fc+df)*t +dphi); % y' *Wc*t %y transpose to be 1 row
    %Wc must be > fc/2 to not overlap
    %df: small change in frequency
    %dphi: small change in phase
end

function yb=bpf(ym,order , BW, fc, fs)%base pass filter
    [b,a]= butter(order, [fc- BW/2, fc + BW/2]/ (fs/2));
    yb= filter(b,a,ym)*2;
end

function yf=lpf(yd,order , BW, fs)%low pass filter
    fc= BW/2;
    [b,a]= butter(order, fc/ (fs/2));
    yf= filter(b,a,yd)*2;
end
