# Impact of Undersampling the K-Space Data and Solutions for Minimizing Artifacts
Authors: Efe Özdilek, Öykü Özbirinci

## Overview
This project was completed as the final project for the EEE 473 Medical Imaging Course at Bilkent University, intructed by 	Assoc. Prof. Emine Ülkü Sarıtaş. The project explores methods to minimize artifacts and aliasing effects caused by undersampling in Magnetic Resonance Imaging (MRI). The study implements and compares eight k-space undersampling schemes to reduce MRI acquisition time without compromising image quality. Compressed Sensing are employed to reconstruct undersampled data effectively.

The project aims to:
- Analyze the impact of various undersampling methods on MRI image quality.
- Identify efficient strategies to maintain diagnostic integrity while reducing data acquisition times.
- Apply advanced compressed sensing techniques like Total Variation Denoising and Wavelet Transform Sparsity Regularization to improve image quality.

---

## Datasets
1. **BrainWeb: Simulated Brain Database McGill University**  
   - **Description**: Contains MRI images with T1, T2, and Proton Density (PD) contrasts. Allows manipulation of noise levels and slice thickness to evaluate undersampling schemes under various conditions.  
   - **URL**: [BrainWeb Simulated Brain Database](https://brainweb.bic.mni.mcgill.ca)

2. **Br35H: Brain Tumor Detection Dataset**  
   - **Description**: Includes MRI images of patients with brain tumors, essential for assessing the ability to distinguish tumors under undersampling scenarios.  
   - **URL**: [Br35H Kaggle Dataset](https://www.kaggle.com/datasets/ahmedhamada0/brain-tumor-detection)

---

## Key Methods
- **Undersampling Techniques:**  
  - Random Undersampling  
  - Variable Density Undersampling  
  - Partial Fourier Method
  - Variable Density and Partial Fourier Undersampling
  - Center-Weighted Undersampling  
  - Radial Undersampling  
  - Uniform Undersampling with Anti-Aliasing Filters  
  - Cartesian Undersampling  

- **Compressed Sensing Techniques:**  
  - Total Variation Denoising  
  - Wavelet Transform Sparsity Regularization

---

## Results
The project demonstrates that tailored undersampling schemes can significantly reduce MRI acquisition time while preserving diagnostic image quality. Key findings include:
- **Partial Fourier Method**: Achieved the best results by leveraging the real-valued nature of MRI images.  
- **Compressed Sensing Techniques**: Effectively recovered image quality from randomly undersampled data.  
- **Radial Undersampling**: Robust against motion artifacts.  

Further details and visual comparisons are provided in the results section of the project paper.

---

## References
1. C. A. Cocosco, V. Kollokian, R.-S. Kwan, and A. C. Evans, “BrainWeb: Online Interface to a 3D MRI Simulated Brain Database,” *NeuroImage*, vol. 5, no. 4, part 2/4, p. S425, 1997, presented at the 3rd International Conference on Functional Mapping of the Human Brain, Copenhagen, May 1997.
2. R.-S. Kwan, A. C. Evans, and G. B. Pike, “MRI simulation-based evaluation of image-processing and classification methods,” *IEEE Transactions on Medical Imaging*, vol. 18, no. 11, pp. 1085–1097, Nov. 1999.
3. R.-S. Kwan, A. C. Evans, and G. B. Pike, “An Extensible MRI Simulator for Post-Processing Evaluation,” *Lecture Notes in Computer Science*, vol. 1131, *Visualization in Biomedical Computing (VBC’96)*, Springer-Verlag, pp. 135–140, 1996.
4. D. L. Collins, A. P. Zijdenbos, V. Kollokian, J. G. Sled, N. J. Kabani, C. J. Holmes, and A. C. Evans, “Design and Construction of a Realistic Digital Brain Phantom,” *IEEE Transactions on Medical Imaging*, vol. 17, no. 3, pp. 463–468, Jun. 1998.
5. M. Lustig, D. Donoho, and J. M. Pauly, “Sparse MRI: The application of compressed sensing for rapid MR imaging,” *Magnetic Resonance in Medicine*, vol. 58, no. 6, pp. 1182–1195, Dec. 2007.
6. OpenAI, “ChatGPT,” OpenAI, San Francisco, CA, USA, 2025. [Online]. Available: [https://chat.openai.com](https://chat.openai.com).
7. Anthropic, “Claude,” Anthropic, San Francisco, CA, USA, 2025. [Online]. Available: [https://www.anthropic.com](https://www.anthropic.com).
8. A. Hamada, “Br35H: Brain Tumor Detection 2020,” Kaggle, 2020. [Online]. Available: [https://www.kaggle.com/datasets/ahmedhamada0/brain-tumor-detection?resource=download](https://www.kaggle.com/datasets/ahmedhamada0/brain-tumor-detection?resource=download).
9. McConnell Brain Imaging Centre, “BrainWeb: Simulated Brain Database,” Montreal Neurological Institute, McGill University. [Online]. Available: [https://brainweb.bic.mni.mcgill.ca](https://brainweb.bic.mni.mcgill.ca).
10. S. Kojima, H. Shinohara, T. Hashimoto, and S. Suzuki, “Undersampling patterns in k-space for compressed sensing MRI using two-dimensional Cartesian sampling,” *Radiological Physics and Technology*, vol. 11, no. 3, pp. 303–319, Sep. 2018.
11. MRIQuestions, “Partial Fourier Imaging,” [Online]. Available: [https://mriquestions.com/partial-fourier.html#](https://mriquestions.com/partial-fourier.html#).
12. J. G. Pipe, “Reconstructing MR images from undersampled data: Data-weighting considerations,” *Magnetic Resonance in Medicine*, vol. 43, no. 6, pp. 867–875, Jun. 2000.
13. M. Murad et al., “Radial Undersampling-Based Interpolation Scheme for Multislice CSMRI Reconstruction Techniques,” *Journal of Healthcare Engineering*, vol. 2021, Article ID 6638588, 2021.
14. İ. Bayram, “Sparsity Regularization in Signal Processing,” [Online]. Available: [https://web.itu.edu.tr/ibayram/ehb372e/SparsityReg/](https://web.itu.edu.tr/ibayram/ehb372e/SparsityReg/).
15. I. W. Selesnick, “Lecture Notes: Total Variation Denoising and MM Algorithms,” [Online]. Available: [https://eeweb.engineering.nyu.edu/iselesni/lecture notes/TVDmm/](https://eeweb.engineering.nyu.edu/iselesni/lecture%20notes/TVDmm/).
16. L. Levesque, “Nyquist sampling theorem: Understanding the illusion of a spinning wheel captured with a video camera,” *Physics Education*, vol. 49, no. 6, pp. 697–701, Nov. 2014.
