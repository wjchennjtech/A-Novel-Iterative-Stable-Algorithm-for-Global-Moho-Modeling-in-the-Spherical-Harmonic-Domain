function [grav_attraction] = moho_forward(moho_boundary,height,deltarho,D0)
  
  R=6378136.3;G=6.673e-11; GM=3986005*1e+8;
  
  nmax=180;nlat=180;nlon=360;lat_min=-89.5;lat_max=89.5;lon_min=-179.5;lon_max=179.5;
  
  Lat=linspace(lat_max, lat_min, nlat); Lon = linspace(lon_min, lon_max, nlon);

  rhoave=5500; rp=R+height;
  
  deltah1(:,1:2)=moho_boundary(:,1:2);
  deltah1(:,3)=moho_boundary(:,3)*1e3-D0;
  ratio1 = deltah1(:,3) ./ (R-D0);


  CCnm1=zeros(nmax+1,nmax+1);SSnm1=zeros(nmax+1,nmax+1);
  CCNM1=zeros(nmax+1,nmax+1);SSNM1=zeros(nmax+1,nmax+1);
  CNM=zeros(nmax+1,nmax+1);SNM=zeros(nmax+1,nmax+1);


  %第一个公式，求解球谐系数
 for k = 1:3   % k 从 1 到 3
        coef1(:,1:2) =  moho_boundary(:,1:2);
        coef1(:,3) = (ratio1(:,1).^k);
        [anm1,bnm1] = AB_matrix(coef1,nlat,nlon);
        [cnm1,snm1] = LS_SHA(anm1,bnm1,coef1,nlat,nmax); 
       for n = 0:nmax
            if n+3 >= k
                C = nchoosek(n+3,k);
            else
                C = 0;
            end
            W1 =((1-D0/R)^(n+3))*3*deltarho/(rhoave*(2*n+1)*(n+3));
            CCNM1(n + 1, :) = W1 * cnm1(n + 1, :) * C;
            SSNM1(n + 1, :) = W1 * snm1(n + 1, :) * C;
       end
       CCnm1 = CCNM1 + CCnm1;
       SSnm1 = SSNM1 + SSnm1;
 end   



%球谐综合部分

for n = 0:nmax
     factor = (n+1)*((R/rp)^(n+2));
     CNM(n+1,:) = factor * CCnm1(n+1,:);
     SNM(n+1,:) = factor * SSnm1(n+1,:);
end

   attraction=synthesis(CNM,SNM,nmax,Lat,Lon);
    attraction =(GM/(R^2))*attraction * 1e5;
    grav_attraction = zeros(nlat*nlon, 3);
    for i = 1:nlat
        for j = 1:nlon
            grav_attraction((i-1)*nlon+j,1) = Lon(j);
            grav_attraction((i-1)*nlon+j,2) = Lat(i);
            grav_attraction((i-1)*nlon+j,3) = attraction(i,j);
        end
    end
end

