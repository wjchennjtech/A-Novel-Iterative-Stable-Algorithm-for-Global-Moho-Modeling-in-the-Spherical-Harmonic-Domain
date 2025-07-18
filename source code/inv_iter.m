 function  depth=inv_iter(grav_attraction,height,tol,max_iter,alpha,D0,deltarho)
     nlat=180;nlon=360;nmax=180;R=6371000;Lon=-179.5:1:179.5;Lat=89.5:-1:-89.5;
     GM=3986005*1e+8;rhoave=5500; rp=R+height;
     
     grav_attraction(:,3)=grav_attraction(:,3)/1e5; 

     CNM=zeros(nmax+1,nmax+1);SNM=zeros(nmax+1,nmax+1);
     CCNM1=zeros(nmax+1,nmax+1);SSNM1=zeros(nmax+1,nmax+1);

     [Anm,Bnm] = AB_matrix(grav_attraction,nlat,nlon);
     [Cnm,Snm] = LS_SHA(Anm,Bnm,grav_attraction,nlat,nmax); 


     for n=0:nmax
         factor=((2*n+1)*rhoave*((R/(R-D0))^(n+3))/(3*deltarho*(n+1)))*((rp^2)/GM)*((rp/R)^n);
         CNM(n+1,:) = factor * Cnm(n+1,:);
         SNM(n+1,:) = factor * Snm(n+1,:);
     end

     fx=synthesis(CNM,SNM,nmax,Lat,Lon);
     moho_height=fx*(R-D0)+D0;
   

     h_old=moho_height;
     
     depth = zeros(nlat*nlon, 3);
     for i = 1:nlat
         for j = 1:nlon
             depth ((i-1)*nlon+j,1) = Lon(j);
             depth ((i-1)*nlon+j,2) = Lat(i);
             depth ((i-1)*nlon+j,3) = moho_height(i,j);
         end
     end
   
     prev_Cnm = CNM;
     prev_Snm = SNM;

     rrms=1000;
     iter=0;
     k=2;

     while  rrms>tol

        deltah1(:,1:2)=depth(:,1:2);
        deltah1(:,3)=depth(:,3)-D0;
        ratio1 = deltah1(:,3) ./ (R-D0);
        coef1(:,1:2) =  depth(:,1:2);
        coef1(:,3) = (ratio1(:,1).^k);
        [anm1,bnm1] = AB_matrix(coef1,nlat,nlon);
        [cnm1,snm1] = LS_SHA(anm1,bnm1,coef1,nlat,nmax); 

        for n = 0:nmax
            if n+3 >= k
                C = nchoosek(n+3,k);
            else
                C = 0;
            end
            W1 =1/(n+3);
            CCNM1(n + 1, :) = W1 * cnm1(n + 1, :) * C;
            SSNM1(n + 1, :) = W1 * snm1(n + 1, :) * C;
        end

        NewCnm=CNM-CCNM1;
        NewSnm=SNM-SSNM1;
        

        lastCnm = alpha * NewCnm + (1-alpha) * prev_Cnm;
        lastSnm = alpha * NewSnm + (1-alpha) * prev_Snm;

        fx1=synthesis(lastCnm,lastSnm,nmax,Lat,Lon);
        
        moho_height=fx1*(R-D0)+D0;

        rrms=rms(moho_height(:)-h_old(:));
        fprintf("Change in elevation RMS = %.10f\n", rrms);
        iter = iter + 1;

        if iter == max_iter 
            break; 
        end
   
        depth = zeros(nlat*nlon, 3);
        for i = 1:nlat
            for j = 1:nlon
             depth ((i-1)*nlon+j,1) = Lon(j);
             depth ((i-1)*nlon+j,2) = Lat(i);
             depth ((i-1)*nlon+j,3) = moho_height(i,j);
            end
        end

        h_old =moho_height;
        prev_Cnm = lastCnm;
        prev_Snm = lastSnm;
        k=k+1;
     end
     

end
