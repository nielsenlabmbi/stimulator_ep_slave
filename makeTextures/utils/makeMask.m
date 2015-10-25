function mask=makeMask(screenRes,x_pos,y_pos,xsizeN,ysizeN,maskradiusN,mask_type)

%compute stimulus mask - one large aperture only
%these masks are screen size to allow correct cropping of rotated stimuli
%1 outside of stimulus, 0 where stimulus should appear

%parameters:
%screenRes: screen height and width
%x_pos, y_pos: position in pixel
%xsizeN, ysizeN: size in pixel
%maskradiusN: radius in pixel
%mask_type: gauss, disc or non



xdom=[1:screenRes.width]-x_pos;
ydom=[1:screenRes.height]-y_pos;
[xdom,ydom] = meshgrid(xdom,ydom); %this results in a matrix of dimension height x width
r = sqrt(xdom.^2 + ydom.^2);


if strcmp(mask_type,'gauss')
    maskT = 1-exp((-r.^2)/(2*maskradiusN^2));
elseif strcmp(mask_type,'disc') %disc is the default
    maskT =1-(r<=maskradiusN);
else
    xran = [x_pos-floor(xsizeN/2)+1  x_pos+ceil(xsizeN/2)];
    yran = [y_pos-floor(ysizeN/2)+1  y_pos+ceil(ysizeN/2)];
    maskT=ones(size(r));
    maskT(yran(1):yran(2),xran(1):xran(2))=0;
end

mask = 0.5*ones(screenRes.height,screenRes.width,2);
mask(:,:,2) = maskT;
