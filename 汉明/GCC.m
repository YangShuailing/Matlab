function [estimated_delays] = GCC(waves10,waves20,fftSize,marginSamples)
%UNTITLED 此处显示有关此函数的摘要
% FFT
  fftSize2=floor(fftSize/2); 
  fft1=fft(waves10,fftSize);
  fft2=fft(waves20,fftSize);
  G12=fft1.*conj(fft2);
  denom=max(abs(G12),1e-6);
  G=G12./denom;
  g=real(ifft(G));
  g=fftshift(g);
  [~, maxIdx] = max(g(fftSize2+1-marginSamples:fftSize2+1+marginSamples));
  estimated_delays = maxIdx - marginSamples - 1; 
 
%    plot(g(fftSize2+1-marginSamples:fftSize2+1+marginSamples))
%    hold on
%   
end


