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
- $K(t+1)-1$ is the last element of frame $t$
- $s[k]^2$ is the energy of $k$-th sample  

#### **What it tells an ML algorithm:**
- **Loudness or Energy:** RMS Energy gives a measure of the energy (loudness) in the audio signal.
- **Dynamics:** it helps register variations in loudness.

##### **Use cases:**
- **Music Genre Classification**
  - Different genres of music have unique loudness dynamics. For example, classical music might have more variation, while electronic music tends to be consistently loud.
- **Speech Recognition**
  - RMS can help distinguish between voiced and unvoiced sounds. Voiced sounds generally have higher energy.
  - Detecting speech activity
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
- $K(t+1)-1$ is the last element of frame $t$
- $sgn(s[k])$ is the sign of $k$-th sample  
     
     
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
- $K(t+1)-1$ is the last element of frame $t$
- $s[k]$ is the amplitude of $k$-th sample  
     
     
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













## References 
Valerio Velardo - [Audio Signal Processing For ML](https://github.com/musikalkemist/AudioSignalProcessingForML)

