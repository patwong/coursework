%Assignement #1 Unit Tests

clear all

%% Q1

p = [20 30 40 1 2 3];
q1_ans = p2m(p);
q1_soln = [0.663413948168938,-0.473021458440361,0.579769465589431,1
    ;0.556670399226419,0.829769465589431,0.0400087565481419,2;
    -0.500000000000000,0.296198132726024,0.813797681349374,3;
    0,0,0,1];

if max(abs(q1_ans(:)-q1_soln(:)))>0.01
    disp('***** Error in p2m *****');
    disp('Correction solution');
    disp(q1_soln);
    disp('Student answer');
    disp(q1_ans);
end

%% Q2

q2_input = [0.86,-0.49,0.31,3; 
    0.55,0.82,0.041,2;
    -0.50,0.29,0.81,3;
    0,0,0,1];
q2_ans = m2p(q2_input);

q2_soln = [19.6986213745803,30.0000000000000,32.6003335736902,3,2,3];

if max(abs(q2_ans(:)-q2_soln(:)))>0.01
    disp('***** Error in m2p *****');
    disp('Correction solution');
    disp(q2_soln);
    disp('Student answer');
    disp(q2_ans);
end


%% Q3

make_matrix

q3_soln = [    0.7660   -0.6428         0   72.1371;
    0.6428    0.7660         0  -11.4979;
         0         0    1.0000         0;
         0         0         0    1.0000];

%
if max(abs(M(:)-q3_soln(:)))>0.01
    disp('***** Error in Q3 *****');
    disp('Correction solution');
    disp(q3_soln);
    disp('Student answer');
    disp(M);
end
     
     
    
%