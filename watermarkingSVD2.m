clc;  clear all;  close all;
% Charger l'image hôte
imageO = imread('imag/im1.png');

% Charger l'image de la marque 
marque = imread('imag/cle.png');
marque = rgb2gray(marque);
% redimenssionner la marque
marque = imresize(marque, size(imageO));



% Appliquer la SVD à l'image hôte
[U, S, V] = svd(double(imageO));

% Insérer la marque dans les valeurs singulières S
alpha = 0.001;  % Facteur de pondération 
marque=double(marque);
S = S + alpha * marque;

% Reconstruire l'image hôte tatouée
imageW = uint8(U * S * V');

% Afficher l'image hôte originale et l'image hôte tatouée
subplot(1, 2, 1);
imshow(imageO);
title('Image Originale');

subplot(1, 2, 2);
imshow(imageW);
title('Image Tatouée');

% Détection de la marque dans l'image tatouée
% Appliquer la SVD à l'image tatouée
[U_tatouee, S_tatouee, V_tatouee] = svd(double(imageW));

% Soustraire 
marque_detectee = (S_tatouee - S) / alpha;

% Afficher l'image de la marque détectée
figure;
imshow(uint8(marque_detectee));
title('Marque Détectée');
