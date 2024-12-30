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

#### **Use cases:**
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

#### **Use cases:**
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

#### **Use cases:**
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
  - Note: we consider only the first half of the frequencies, as they duplicate themselves in the second half   
    $k = \frac{N}{2} \Rightarrow F(\frac{N}{2}) = \frac{s_{r}}{2}$   
    where:
      - $F(\frac{N}{2})$ is the Nyquist Frequency
      - $s_{r}$ is the sample rate

#### **What it tells an ML algorithm:**
- **Frequency Content:** Identifies the presence and intensity of specific frequencies in the signal.
- **Harmonics and Periodicity:** Detect patterns and periodic structures in the audio signal (by analyzing the spacing and intensity of peaks, periodicity can be detected).

#### **Use cases:**
- **Speech Processing**
  - Analyzing the frequency patterns unique to a speaker's voice (speaker recognition).
  - Differentiating between voiced and unvoiced sounds.
- **Music Genre Classification**
  - Recognition of instruments as they produce different frequency spectra.
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
- $S(m, k)$ represents the magnitude of the frequency $k$ at time $m$,
- $H$ is a hop length,
- $m*H$ is the starting sample of a current frame,
- $w[n]$ is a windowing function.

#### **What it tells an ML algorithm:**
- **Time-Frequency Patterns:** Provides detailed information about how sound energy is distributed across time and frequency.
- **Harmonic and Transient Events:** Helps identify tonal patterns (e.g., notes in music) and transient events (e.g., claps or plosives in speech).

#### **Use cases:**
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


### Mel Spectrogram
A **Mel Spectrogram** is a variation of the spectrogram where the frequency axis is transformed to the Mel scale, a perceptual scale that mimics how humans perceive sound. The Mel scale places more emphasis on lower frequencies (where human hearing is more sensitive) and less emphasis on higher frequencies.
  
Pipeline:  
1. Start with the Spectrogram.
2. Apply a set of overlapping triangular Mel filter banks to the power or magnitude spectrum.
![ Mel filter banks](https://siggigue.github.io/pyfilterbank/_images/melbank-1_00.png)
3. Take the logarithm of the filtered values for dynamic range compression.

Formula
```math
M(m, t) = \sum_{f=0}^{F-1} X(t, f)^2 \cdot H_m(f)
```
where:  
- $M(m, t)$ is the Mel spectrogram at Mel filter bank $m$ and time frame $t$,
- $X(t, f)$ is the STFT magnitude at time $t$ and frequency $f$.
- $H_m(f)$ is the $m$-th Mel filter, defined to map linear frequencies $f$ to the Mel scale.

The Mel scale is computed as:
```math
Mel(f) = 2595 \cdot \log_{10}(1 + \frac{f}{500})
```

#### **What it tells an ML algorithm:**
- **Perceptually Relevant Features:** Encodes sound in a way that aligns with human auditory perception.
- **Frequency Emphasis:** Prioritizes frequencies that are most meaningful for human hearing, which is particularly useful in speech and music processing.

#### **Use cases:**
- **Speech Processing**
  - Mel spectrograms capture the subtle frequency changes that reflect emotional tones.
- **Music Analysis**
  - Emphasizing tonal and harmonic features aligned with human perception which helps to classify a genre.
  - Encodes the distinct timbre of instruments effectively.
- **Audio Event Detection**
  - Identifying environmental sounds like sirens or animal calls, which often have unique perceptual frequency patterns.  
- **Deep Learning Applications**
  - Mel spectrograms are commonly used as inputs to CNNs and other deep learning models for audio classification tasks.



### Mel-Frequency Cepstral Coefficients (MFCCs)
**MFCCs** are a compact representation of the audio signal that captures its perceptually relevant features. They summarize the spectral envelope of a signal by analyzing its frequency content on the Mel scale and then applying a discrete cosine transform (DCT) to decorrelate the features and reduce dimensionality.
  
Pipeline:  
1. Start with the Mel Spectrogram.
2. Applying the common logarithm to compress the dynamic range.
3. Performing a **Discrete Cosine Transform** (simplified version of Fourier Transform) on the Mel filter bank energies to produce the coefficients.

Formula
```math
C(n) = \sum_{m=0}^{N-1} \log [M(m, t)] \cdot \cos \left( \frac{\pi n (m + 0.5)}{N} \right)
```
where:  
- $C(n)$ is the $n$-th MFCC,
- $M(m, t)$ is the Mel Spectrogram,
- $N$ is the number of Mel filters.

#### **What it tells an ML algorithm:**
- **Compact Audio Features:** MFCCs reduce the data size while retaining the most important audio features.
- **Speaker Characteristics:** Encodes the vocal tract information, which is useful in identifying individual speakers.
- **Phonetic Content:** Captures the spectral information related to phonemes in speech.

#### **Use cases:**
- **Speech Processing**
  - MFCCs are the standard feature for converting speech into text.
  - Encodes the unique vocal characteristics of individuals (speaker identification). 
- **Music Analysis**
  - Summarizes the tonal and timbral characteristics of music which helps to classify a genre.
  - Captures distinct timbral patterns associated with different instruments.
- **Audio Event Detection**
  - Identifies events such as footsteps, door slams, or alarms based on their characteristic spectral shapes.   
- **Emotion Recognition in Speech**
  - Encodes subtle variations in speech that correlate with emotional states.

### Band Energy Ratio
**Band Energy Ratio (BER)** is a feature that measures the proportion of energy in a specific frequency band relative to the total energy of the audio signal. It helps in identifying which frequency ranges dominate the signal, providing insights into its spectral distribution.

Formula
```math
BER = \frac{\sum_{k=k_1}^{k_2} X[k]^2}{\sum_{k=0}^{K-1} X[k]^2}
```
where:  
- $X[k]$ is the magnitude spectrum at frequency bin $k$,
- $k_1$ and $k_2$ are the frequency bins defining the band of interest,
- $K$ is the total number of frequency bins.

#### **What it tells an ML algorithm:**
- **Frequency Band Dominance:** Indicates whether certain frequency bands carry most of the signal’s energy.
- **Signal Characteristics:** Helps differentiate sounds with dominant low-frequency energy (e.g., bass-heavy music) from those with high-frequency emphasis (e.g., fricative sounds in speech).

#### **Use cases:**
- **Speech Processing**
  - Voiced sounds tend to have more energy in the lower frequencies, while unvoiced sounds have higher-frequency energy (voiced vs. unvoiced detection).
- **Music Analysis**
  - Different genres emphasize different frequency ranges (e.g., EDM might emphasize bass frequencies, while classical music is more balanced).
  - Instruments produce energy in specific frequency bands (e.g., drums in low frequencies, violins in mid-high frequencies).
- **Audio Event Detection**
  - Identify specific sounds based on their frequency bands, such as alarms (high frequency) or footsteps (low frequency).  
- **Environmental Sound Classification**
  - Differentiating between environments with low-frequency sounds (e.g., traffic noise) versus high-frequency sounds (e.g., bird calls).

### Spectral Centroid
**The Spectral Centroid** is a feature that measures the "center of mass" of the spectrum. It indicates where the majority of the signal's energy is concentrated in the frequency domain. A higher spectral centroid corresponds to a "brighter" or "sharper" sound, while a lower centroid indicates a "darker" or "warmer" sound.

Formula
```math
C = \frac{\sum_{k=0}^{K-1} f[k] \cdot |X[k]|}{\sum_{k=0}^{K-1} |X[k]|}
```
where:  
- $f[k]$ is the frequency of the $k$-th bin,
- $|X[k]|$ is the magnitude of the spectrum at frequency bin $k$,
- $K$ is the total number of frequency bins.

#### **What it tells an ML algorithm:**
- **Brightness of Sound:** Higher spectral centroids indicate high-frequency dominance, associated with "bright" sounds.
- **Timbre Characteristics:** Useful for distinguishing instruments or sounds with varying frequency distributions.

#### **Use cases:**
- **Speech Processing**
  - Angry or excited speech often has a higher centroid than calm or sad speech.
- **Music Analysis**
  - Brighter genres (e.g., electronic) tend to have higher spectral centroids, while darker genres (e.g., classical or jazz) have lower centroids.
  - Helps differentiate between instruments like violins (higher centroid) and cellos (lower centroid).
- **Environmental Sound Classification**
  - Classifying environments like urban settings (higher centroid due to noise) versus natural settings (lower centroid due to softer sounds).

### Spectral Bandwidth
**The Spectral Bandwidth** measures the spread or width of the frequencies around the Spectral Centroid. It quantifies how "wide" the frequency distribution is, reflecting whether the sound is sharp and focused or broad and diffuse.   

Formula
```math
BW = \frac{\sum_{k=0}^{K-1} |X[k]| \cdot (f[k] - C)^2}{\sum_{k=0}^{K-1} |X[k]|}
```
where:  
- $BW$ is the spectral bandwidth,
- $C$ is the spectral centroid,
- $|X[k]|$ is the magnitude of the spectrum at frequency bin $k$,
- $f[k]$ is the frequency of the $k$-th bin
- $K$ is the total number of frequency bins.

#### **What it tells an ML algorithm:**
- **Frequency Distribution:** Indicates whether the sound has concentrated or widely spread frequencies.
- **Sound Texture:** Helps differentiate sharp, high-energy sounds from smoother, more diffuse ones.

#### **Use cases:**
- **Speech Processing**
  - Excited or angry speech tends to have a wider spectral bandwidth compared to calm speech.
- **Music Analysis**
  - Instruments like cymbals have broader bandwidths, while flutes or violins tend to have narrower bandwidths.
  - Brighter, noisier genres (e.g., EDM) often have larger bandwidths, while softer genres (e.g., classical) have smaller bandwidths.
- **Environmental Sound Classification**
  - Helps classify environments with broad-band noise (e.g., urban traffic) versus narrow-band noise (e.g., bird calls).
- **Audio Event Detection**
  - Distinguishing between sharp, transient sounds (e.g., claps or crashes) with high bandwidth and continuous tones with low bandwidth.    
 


## References 
Valerio Velardo - [Audio Signal Processing For ML](https://github.com/musikalkemist/AudioSignalProcessingForML)   
PyFilterbank - [Mel Filter Bank](https://siggigue.github.io/pyfilterbank/melbank.html)

