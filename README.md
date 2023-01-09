## 📝 Table of Contents

- [About](#about)
- [Input signals](#input)
- [Frequency domain](#freq)
- [Modulated signal](#modulated-signal)
- [Demodulated signal](#demodulated-signal)
- [Contributors](#contributors)



## About <a name = "about"></a>
> this is a project to modulate three speech signals using the following scheme: `𝑠(𝑡) = 𝑥1(𝑡) cos 𝜔1𝑡 + 𝑥2(𝑡) cos 𝜔2𝑡 + 𝑥3(𝑡) sin 𝜔2𝑡`, and then perform synchronous demodulation,it simulates multiplexing three speech signals on two carriers with two different frequencies where two of these signals are modulated using quadrature amplitude modulation, then we demodulate the three signals and restore them using synchronous carrier demodulation, and phase shifts.

## Input signals <a name = "input"></a>
### Signal 1

![image](https://user-images.githubusercontent.com/88618793/210906353-d2033c6a-19d2-47b9-baec-c86171ee3e29.png)
      
### Signal 2

![image](https://user-images.githubusercontent.com/88618793/210906767-0a779312-2094-4eb7-b619-55ba7500e9b0.png)

### Signal 3

![image](https://user-images.githubusercontent.com/88618793/210906797-6fad20b7-1c7e-469e-b479-5a80e64d748e.png)


## Frequency domain <a name = "freq"></a>

### Signal 1
      
![image](https://user-images.githubusercontent.com/88618793/210906831-1063795c-34ad-4b4b-b88e-5f3f1907d717.png)

### Signal 2

![image](https://user-images.githubusercontent.com/88618793/210906882-091f14bb-0300-42a7-9c00-07fef32d20ab.png)

### Signal 3

![image](https://user-images.githubusercontent.com/88618793/210906913-fa9b15f5-a9fd-4dd2-b596-64b0f1fbb6a4.png)

## Modulated signal <a name = "modulated-signal"></a>

Modulating the input signals on different carriers by multiplying : 
- The first signal by cos(ω1 * t) where ω1 is an angular frequency in rad/sec
- The second signal by cos(ω2 * t) where ω2 is an angular frequency in rad/sec
- The third signal by sin(ω2 * t) where ω2 is an angular frequency in rad/sec

ω1 = 2 * M_PI * f1 where f1 = 100,000 Hz  \
ω2 = 2 * M_PI * f2 where f2 = 150,000 Hz

<div align='center'>

![image](https://user-images.githubusercontent.com/88618793/210905073-cd7bfb8b-3686-4e1b-ae9c-68141c15d5db.png)

</div>

## Demodulation signal: <a name = "demodulated-signal"></a>
Inorder to demodulate the recieved signal at the reciever we use a synchronous carrier as follows:
- The Modulated signal is multiplied by cos(ω1 * t) where ω1 is an angular frequency in rad/sec then a low pass filter with freq = f1 is applied to restore signal 1
- The Modulated signal is multiplied by cos(ω2 * t) where ω2 is an angular frequency in rad/sec then a low pass filter with freq = f2 is applied to restore the second signal
- The Modulated signal is multiplied by sin(ω2 * t) where ω2 is an angular frequency in rad/sec then a low pass filter with freq = f2 is applied to restore the third signal

ω1 = 2 * M_PI * f1 where f1 = 100,000 Hz  \
ω2 = 2 * M_PI * f2 where f2 = 150,000 Hz

### Signal 1
      
![image](https://user-images.githubusercontent.com/88618793/210907187-94d02e0b-afa7-4b80-afb5-985f351c8beb.png)
      
### Signal 2

![image](https://user-images.githubusercontent.com/88618793/210907205-3aba7459-7b1c-442d-8bb8-a8a4f36a051c.png)

### Signal 3

![image](https://user-images.githubusercontent.com/88618793/210907218-cdd05b81-ff9d-473b-8a3c-0e02e8bf4ac1.png)


## Contributors <a name = "contributors"></a>

<table>
  <tr>
    <td align="center">
    <a href="https://github.com/asmaaadel0" target="_black">
    <img src="https://avatars.githubusercontent.com/u/88618793?s=400&u=886a14dc5ef5c205a8e51942efe9665ed8fd4717&v=4" width="150px;" alt="Asmaa Adel"/>
    <br />
    <sub><b>Asmaa Adel</b></sub></a>
    </td>
    <td align="center">
    <a href="https://github.com/zeinabmoawad" target="_black">
    <img src="https://avatars.githubusercontent.com/u/92188433?v=4" width="150px;" alt="Zeinab moawad"/>
    <br />
    <sub><b>Zeinab Moawad</b></sub></a>
    </td>
    
    
  </tr>
 </table>

