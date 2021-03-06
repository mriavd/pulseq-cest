# pulseq-cest

Welcome to the **pulseq-cest** repository. Here, published and approved CEST saturation blocks are made available in the open pulseq standard (https://pulseq.github.io/).
This allows exact comparison of CEST saturation blocks with newly developed or adapted saturation blocks for reproducible CEST research.
Below you find a list of already defined CEST presaturation schemes as .seq files, together with the corresponding  Matlab generation file.
All .seq files can be loaded in Matlab for plotting and detailed inspection, but also for simulation via the built-in Bloch-McConnell simulation in [pulseq-cest-sim](pulseq-cest-sim).

## Quick start
To view pulseq files in Matlab, download the whole repository, add it to your Matlab path, and run the file **plot_seq_file.m**. You can view either the entire .seq file with all repetitions or have a detailled look at a single saturation phase.
Every .seq file can be simulated by running [pulseq-cest-sim/Run_pulseq_cest_Simulation.m](pulseq-cest-sim/Run_pulseq_cest_Simulation.m). The simulation uses compiled code, which is so far available for 64-bit Windows and Linux (Debian-based) systems. However, the source code is included here, so that you can compile it for your specific OS (and hopefully share it again with us). For more infos about the simulation, have a look at the subfolder [Readme](pulseq-cest-sim/Readme.md).

|identifier with .seq and .m file                                                                                                      |            scheme  (seq.plot)                                          |  Description              |  Publication                                                                  | Approved by Authors|
|------------------                                                                                                                               |:-------------------:                                                   |-------------:             |--------------                                                                 |--------------------|
| [APTw_3T_001_Zhou2019.seq](cest-seq-library/APTw_3T_001_Zhou2019.seq),<br>[APTw_3T_001_Zhou2019.m](cest-seq-library/APTw_3T_001_Zhou2019.m)     | <img src="cest-seq-library/APTw_3T_001_Zhou2019.png" width="300"/>     | APTw, 2µT, 0.8s, DC95     | [Zhou et al 2019](https://onlinelibrary.wiley.com/doi/full/10.1002/jmri.26645)| **not approved!**
| [APTw_3T_002_Keupp2011.seq](cest-seq-library/APTw_3T_002_Keupp2011.seq),<br>[APTw_3T_002_Keupp2011.m](cest-seq-library/APTw_3T_002_Keupp2011.m) | <img src="cest-seq-library/APTw_3T_002_Keupp2011.png" width="300"/>    | APTw, 2µT, 2s, DC100      | [Togao et al 2016](https://doi.org/10.1371/journal.pone.0155925) | **not approved!** |
| [APTw_3T_003_GLINT.seq](cest-seq-library/APTw_3T_003_GLINT.seq),<br>[APTw_3T_003_GLINT.m](cest-seq-library/APTw_3T_003_GLINT.m)                 | <img src="cest-seq-library/APTw_3T_003_GLINT.png" width="300"/>        | APTw, 2.22µT, 1.8s, DC50  | [cest-sources (APTw_1)](https://cest-sources.org/doku.php?id=standard_cest_protocols) | approved |
| [DGE_7T_001_Xu2019.seq](cest-seq-library/DGE_7T_001_Xu2019.seq),<br>[DGE_7T_001_Xu2019.m](cest-seq-library/DGE_7T_001_Xu2019.m)                 | <img src="cest-seq-library/DGE_7T_001_Xu2019.png" width="300"/>        | APTw, 2µT, 0.8s, DC50     | [Xu et al 2019](doi:...)| **not approved!** |
| [Glut_7T_001_Cai2003.seq](cest-seq-library/Glut_7T_001_Cai2003.seq),<br>[Glut_7T_001_Cai2003.m](cest-seq-library/Glut_7T_001_Cai2003.m)         | <img src="cest-seq-library/Glut_7T_001_Cai2003.png" width="300"/>      | APTw, 2µT, 0.8s, DC50     | [Cai et al 2003](doi:...)| **not approved!** |
| [DGErho_3T_001_Herz2019.seq](cest-seq-library/DGErho_3T_001_Herz2019.seq),<br>[DGErho_3T_001_Herz2019.m](cest-seq-library/DGErho_3T_001_Herz2019.m)         | <img src="cest-seq-library/DGErho_3T_001_Herz2019.png" width="300"/>      | SLExp, 4µT, 0.12s    | [Herz et al 2019](https://doi.org/10.1002/mrm.27857)| approved |


## Sequence definition questions

1. What is the saturation pulse duration tp

2. What is the interpulse delay td and the duty-cycle DC= tp/(tp+td)

3. What is the saturation pulse flipangle? What is the average amplitude of the pulse, the average amplitude of the pulse train (cwae) and the average power (cwpe) of the pulse train.

4. what is the exact pulse shape? Can it be given as a textfile with sampling points

5. what is the phase after the RF pulse, is it set to zero or is the accumulated phase kept as it is.

6. what is the exact Trec used, meaning the time after the last readout pulse and before the next saturation starts.

7. Is there an additional normalization scan acquired. e.g. an unsaturated M0 scan. How long is the relaxation delay before this scan. Is it also acquired after a far-offresonant saturation pulse train? what is the offset frequency then, and what was the power used. 

