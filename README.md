# Efficient Waveform Covariance Matrix Design and Antenna Selection for MIMO Radar

This repo contains the implementation for the paper: [Efficient Waveform Covariance Matrix Design and Antenna Selection for MIMO Radar](https://www.sciencedirect.com/science/article/abs/pii/S0165168421000244)

by [Arindam Bose](https://arindambose.com/), [Shahin Khobahi](https://khobahi.net), [Mojtaba Soltanalian](https://msol.people.uic.edu/), [WaveOPT Lab](https://waveopt-lab.uic.edu/), UIC.

-------------------------------------------------------------------------------------
Controlling the radar beam-pattern by optimizing the transmit covariance matrix is a well-established approach for performance enhancement in multiple-input-multiple-output (MIMO) radars. In this paper, we investigate the joint optimization of the waveform covariance matrix and the antenna position vector for a MIMO radar system to approximate a given transmit beam-pattern, as well as to minimize the cross-correlation between the probing signals at a number of given target locations. We formulate this design task as a non-convex optimization problem and then propose a cyclic optimization approach to efficiently approximate its solution. We further propose a local binary search algorithm in order to efficiently design the corresponding antenna positions. We show that the proposed method can be extended to the more general case of approximating the given beam-pattern using a minimal number of antennas as well as optimizing their positions. Our numerical investigations demonstrate a great performance both in terms of accuracy and computational complexity, making the proposed framework a good candidate for usage in real-time radar waveform processing applications such as MIMO radar transmit beamforming for aerial drones that are in motion.

Current weblink: [Elsevier Signal Processing](https://www.sciencedirect.com/science/article/abs/pii/S0165168421000244), [ArXiv](https://arxiv.org/abs/2002.06025)
    
## References

If you find the code / idea inspiring for your research, please consider citing the following

```
@article{bose2021efficient,
title = "Efficient waveform covariance matrix design and antenna selection for MIMO radar",
journal = "Signal Processing",
volume = "183",
pages = "107985",
year = "2021",
issn = "0165-1684",
doi = "https://doi.org/10.1016/j.sigpro.2021.107985",
url = "http://www.sciencedirect.com/science/article/pii/S0165168421000244",
author = "Arindam Bose and Shahin Khobahi and Mojtaba Soltanalian",
keywords = "Antenna selection, Beam-forming, Dynamic programming, MIMO radar, Waveform design",
}
```
