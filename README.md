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
$$RMS = sqrt((1 / N) * sum(x[i]^2 for i in range(N)))$$
where N is the number of samples in the segment. 
## References 
Valerio Velardo - [Audio Signal Processing For ML](https://github.com/musikalkemist/AudioSignalProcessingForML)

