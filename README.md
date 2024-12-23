# Audio Signal Features

This repository provides a **Jupyter Notebook** that demonstrates how to extract and visualize key audio features from a given audio file. As an illustrative example, it uses *Gymnopédie No.1* by **Erik Satie**, included in the `audio` directory.

## Extracted Features

**Time-Domain Features:**
- Waveform
- Root-Mean-Square (RMS) Energy
- Zero-Crossing Rate
- Amplitude Envelope

**Frequency-Domain Features:**
- Discrete Fourier Transform (DFT)
- Spectrogram
- Mel Spectrogram
- Mel-Frequency Cepstral Coefficients (MFCCs)
- Band Energy Ratio
- Spectral Centroid
- Bandwidth

## Time-Domain Features
### Root-Mean-Square (RMS) Energy
**RMS Energy** measures the magnitude of the audio signal over time. It calculates the square root of the average of the squared amplitudes of the signal. This provides a sense of the overall loudness or intensity of the sound.  
  
Formula:  
```math
RMS(t) = \sqrt{\frac{1}{K} \sum_{k=K*t}^{K(t+1)-1} s[k]^2}
```
where:  
- $K$ is the frame size,
- $k=K*t$ is the first element of frame $t$,
- $K(t+1)-1$ is the last element of frame $t$,
- $s[k]^2$ is the energy of $k$-th sample.  

#### **What it tells an ML algorithm:**
- **Loudness or Energy:** RMS Energy gives a measure of the energy (loudness) in the audio signal.
- **Dynamics:** it helps register variations in loudness.

##### **Use cases:**
- **Music Genre Classification**
  - Different genres of music have unique loudness dynamics. For example, classical music might have more variation, while electronic music tends to be consistently loud.
- **Speech Recognition**
  - RMS can help distinguish between voiced and unvoiced sounds. Voiced sounds generally have higher energy.
  - Detecting speech activity.
- **Emotion Detection in Speech**
  - RMS can help identify emotional states like anger or excitement where the loudness levels are typically higher.  
- **Audio Event Detection**
  - Useful in detecting events such as claps, bangs, or other transient sounds where energy spikes.


      
### Zero-Crossing Rate    
**Zero-Crossing Rate** measures how frequently the signal crosses the zero amplitude level (time axis) within a given time frame. It counts the number of times the audio waveform changes sign (from positive to negative and vice versa).
    
Formula:  
```math
ZCR(t) = \frac{1}{2} \sum_{k=K*t}^{K(t+1)-1} \left| \text{sgn}(s[k]) - \text{sgn}(s[k+1]) \right|
```
where:  
- $K$ is the frame size,
- $k=K*t$ is the first element of frame $t$,
- $K(t+1)-1$ is the last element of frame $t$,
- $sgn(s[k])$ is the sign of $k$-th sample.  
     
     
#### **What it tells an ML algorithm:**
- **Frequency Content:** a high zero-crossing rate indicates that the signal contains high-frequency components (e.g. noisy signals).

##### **Use cases:**
- **Music Genre Classification**
  - Instruments like guitars or violins often produce smooth waveforms (low ZCR), while     percussive instruments exhibit high ZCR.
  - Identify sections of music with rapid transitions or percussive beats.
- **Speech Recognition**
  - Differentiate between vowels and consonants, as voiced sounds have low ZCR.
  - Detect when speech starts and ends by analyzing signal frequency content.
- **Emotion Detection in Speech**
  - Unvoiced components are higher during emotions such as anger or frustration, leading to increased ZCR.
- **Audio Event Detection**
  - Useful for detecting sharp, transient noises like clicks, keyboard typing, or environmental sounds (e.g., snapping fingers).


      
### Amplitude Envelope    
**Amplitude Envelope** captures the maximum amplitude of the audio signal over small time frames. It provides a representation of the signal's loudness dynamics, showing how the volume changes over time. Unlike RMS energy, which gives the average energy, the amplitude envelope tracks the peaks in each frame.
    
Formula:  
```math
A(t) = \max_{k=K*t}^{K(t+1)-1} \left( s[k] \right)
```
where:  
- $K$ is the frame size,
- $k=K*t$ is the first element of frame $t$,
- $K(t+1)-1$ is the last element of frame $t$,
- $s[k]$ is the amplitude of $k$-th sample.  
     
     
#### **What it tells an ML algorithm:**
- **Loudness Peaks:** Helps identify the highest points of intensity in the signal, providing insight into its dynamics.
- **Temporal Structure:** Tracks changes in loudness over time, useful for identifying rhythmic patterns or onsets of sound events.

##### **Use cases:**
- **Speech Processing**
  - Detecting when speech starts or ends based on sudden changes in loudness.
  - Emotional speech often shows greater variations in the amplitude envelope compared to neutral speech.
- **Music Analysis**
  - Instruments like drums exhibit sharp amplitude envelopes, while strings have smoother changes.
  - Detect beats in rhythmic music by analyzing sharp envelope spikes.
- **Sound Event Detection**
  - Recognizing transient sounds (e.g., claps, footsteps) which produce sharp peaks in the envelope.
- **Environmental Sound Classification**
  - Identify consistent sounds (e.g., rain) versus dynamic sounds (e.g., alarms or bird calls).



## Frequency-Domain Features
### Discrete Fourier Transform (DFT)
**The Discrete Fourier Transform (DFT)** is a mathematical operation that transforms a discrete-time signal from the time domain to the frequency domain. It provides information about the signal's frequency components, showing how much of each frequency is present in the signal.
  
Formula:  
```math
\hat{x}[k] = \sum_{n=0}^{N-1} x[n] \cdot e^{-i \cdot 2\pi \cdot n \cdot \frac{k}{N}}
```
where:  
- $\hat{x}[k]$ represents the magnitude and phase of the $k$-th frequency bin,
- $k$ the frequency index, ranging from $0$ to $(N-1)$.
  - Note: we consider only the first half of the frequencies, as they duplicate themselft in the second half   
    $k = \frac{N}{2} \Rightarrow F(\frac{N}{2}) = \frac{s_{r}}{2}$   
    where:
      - $F(\frac{N}{2})$ is the Nyquist Frequency
      - $s_{r}$ is the sample rate

#### **What it tells an ML algorithm:**
- **Frequency Content:** Identifies the presence and intensity of specific frequencies in the signal.
- **Harmonics and Periodicity:** Detect patterns and periodic structures in the audio signal (by analyzing the spacing and intensity of peaks, periodicity can be detected).

##### **Use cases:**
- **Speech Processing**
  - Analyzing the frequency patterns unique to a speaker's voice (speacker recognition).
  - Differentiating between voiced and unvoiced sounds.
- **Music Genre Classification**
  - Recogition of instruments as they produce different frequency spectra.
  - Identifying harmonic structures in music.
- **Audio Event Detection**
  - Detect sounds like sirens or alarms with distinct frequency patterns.  
- **Environmental Sound Classification**
  - Different environments (e.g., forest vs. city) have characteristic frequency profiles.



### Spectrogram
A **spectrogram** is a visual representation of the frequency content of an audio signal over time. It combines both time and frequency domains by showing how the energy of different frequencies evolves over time. Typically, it is derived by applying the Short-Time Fourier Transform (STFT) to the audio signal and then plotting the magnitude of the resulting frequency components.
  
Pipeline:  
1. The signal is divided into overlapping frames.
2. Each frame undergoes a Fourier Transform to calculate its frequency content.
3. The squared magnitude of the frequency components for each frame is plotted as intensity values on a time-frequency grid.

Formula (STFT)
```math
S(m, k) = \sum_{n=0}^{N-1} x[n+m*H] \cdot w[n] \cdot e^{-i \cdot 2\pi \cdot n \cdot \frac{k}{N}}
```
where:  
- $S(m, k)$ represents the magnitude of the frequency $k$ at time $m$
- $H$ is a hop length,
- $m*H$ is the starting sample of a current frame,
- $w[n]$ is a windowing funtion.

#### **What it tells an ML algorithm:**
- **Time-Frequency Patterns:** Provides detailed information about how sound energy is distributed across time and frequency.
- **Harmonic and Transient Events:** Helps identify tonal patterns (e.g., notes in music) and transient events (e.g., claps or plosives in speech).

##### **Use cases:**
- **Speech Processing**
  - Detecting phonemes based on their unique time-frequency patterns.
  - Capturing individual vocal characteristics present in the spectral patterns.
- **Music Analysis**
  - Identifying harmonic structures in music.
  - Different genres exhibit distinct spectral patterns (e.g., percussive beats in EDM vs. harmonic tones in classical music).
- **Audio Event Detection**
  - Recognizing environmental sounds like alarms, footsteps, or animal calls.  
- **Deep Learning Applications**
  - Spectrograms are often converted into 2D images and used as input for Convolutional Neural Networks (CNNs), enabling powerful feature extraction.





## References 
Valerio Velardo - [Audio Signal Processing For ML](https://github.com/musikalkemist/AudioSignalProcessingForML)

