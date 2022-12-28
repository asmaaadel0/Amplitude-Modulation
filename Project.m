%///////////////////////////////////////////////////////%
%       Read audio files, Plotting in time domain       %
%///////////////////////////////////////////////////////%

% File 1
[signal1, Fs_signal1] = audioread("wav1.wav");
signal1 = signal1(:,1) + signal1(:,2);
lenSignal1 = length(signal1);
figure(1)
%plotting in time domain
plot(signal1)
title("signal 1 time domain")
xlabel("n(samples)")
ylabel("signal1[n]")

% File 2
[signal2, Fs_signal2] = audioread("wav2.wav");
signal2 = signal2(:,1) + signal2(:,2);
lenSignal2 = length(signal2);
figure(2)
%plotting in time domain
plot(signal2)
title("signal 2 time domain")
xlabel("n(samples)")
ylabel("signal2[n]")

% File 3
[signal3, Fs_signal3] = audioread("wav3.wav");
signal3 = signal3(:,1) + signal3(:,2);
lenSignal3 = length(signal3);
figure(3)
%plotting in time domain
plot(signal3)
title("signal 3 time domain")
xlabel("n(samples)")
ylabel("signal3[n]")


%/////////////////////////////////////////////////////////////////////////%
%        Convert to Frequency domain, Get the frequency increments        %
%/////////////////////////////////////////////////////////////////////////%
% first signal
f_signal1=(-Fs_signal1/2:Fs_signal1/lenSignal1:Fs_signal1/2-Fs_signal1/lenSignal1);%frequency axis
fft_signal1 = abs(fft(signal1));
figure(4)
plot(f_signal1, fftshift(fft_signal1))
xlabel("f(Hz)")
ylabel("Fourier coefficient amplitude")
title("Signal1 amplitudes against sampling frequency")

% second signal
f_signal2=(-Fs_signal2/2:Fs_signal2/lenSignal2:Fs_signal2/2-Fs_signal2/lenSignal2);%frequency axis
fft_signal2 = abs(fft(signal2));
figure(5)
plot(f_signal2, fftshift(fft_signal2))
xlabel("f(Hz)")
ylabel("Fourier coefficient amplitude")
title("Signal2 amplitudes against sampling frequency")

% third signal
f_signal3=(-Fs_signal3/2:Fs_signal3/lenSignal3:Fs_signal3/2-Fs_signal3/lenSignal3);%frequency axis
fft_signal3 = abs(fft(signal3));
figure(6)
plot(f_signal3, fftshift(fft_signal3))
xlabel("f(Hz)")
ylabel("Fourier coefficient amplitude")
title("Signal3 amplitudes against sampling frequency")

%////////////////////////////////////////////////////////%
%                 Resampling the signals                 %
%////////////////////////////////////////////////////////%
%first signal
Fs_new = 250000;
[P, Q] = rat(Fs_new/Fs_signal1);
re_signal1 = resample(signal1, P, Q);

%second signal
[P, Q] = rat(Fs_new/Fs_signal2);
re_signal2 = resample(signal2, P, Q);

%third signal
[P, Q] = rat(Fs_new/Fs_signal3);
re_signal3 = resample(signal3, P, Q);