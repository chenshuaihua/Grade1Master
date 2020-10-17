clear all;
close all;
%Initialize parameters
swarm_size=50; %the size of swarm
step_max=400;  %the maximum of iteration steps
w_max=1.2;     %the maximum of the velocity weight
w_min=0.4;     %the minimum of the velocity weight
c_self=1;      %constant of the self experience
c_social=1;    %constant of the social experience
pop_max1=60;   %the maximum of the parameter space for the 1st variable
pop_max2=60;   %the maximum of the parameter space for the 2nd variable
pop_min1=-60;  %the minimum of the parameter space for the 1st variable
pop_min2=-60;  %the minimum of the parameter space for the 2st variable
v_max1=.15*(pop_max1-pop_min1); %the maximum of the velocity,15% of the parameters space
v_max2=.15*(pop_max2-pop_min2);

pop_position(1,:)=(pop_max1-pop_min1)*(rand(1,swarm_size))+pop_min1; %Initialize the popular position
pop_position(2,:)=(pop_max2-pop_min2)*(rand(1,swarm_size))+pop_min2;
pop_fitness=ones(swarm_size,1);  %Initialize the popular fitness
pop_velocity=v_max2*rand(2,swarm_size); %Initialize the popular velocity
lbest_fitness=inf*ones(swarm_size,1);   %Initialize the local best fitness as inf
lbest_position=pop_position;      
gbest_fitness=zeros(1,step_max);     %Initialize the global best fitness 
gbest_position=zeros(2,step_max);
gbest_current_fitness=inf;
gbest_current_position=zeros(2,1);
gb_pos=pop_position;

for iter=1:step_max
    %Calculate the fitness and find the lbest_position and gbest_position
    for pop=1:swarm_size
        pop_fitness(pop)=CalFitness(pop_position(:,pop));
        if(pop_fitness(pop)<lbest_fitness(pop))
            lbest_fitness(pop)=pop_fitness(pop);
            lbest_position(:,pop)=pop_position(:,pop);
        end
    end
    [gbest,pos_best]=min(lbest_fitness);
    if gbest<gbest_current_fitness
        gbest_current_fitness=gbest;
        gbest_current_position=lbest_position(:,pos_best);
    end
    gbest_fitness(iter)=gbest_current_fitness;
    gbest_position(:,iter)=gbest_current_position;
    for pop=1:swarm_size
        gb_pos(:,pop)=gbest_current_position;
    end
    %Update the weight,velocity and position
    w=w_max-(w_max-w_min)*iter/step_max;
    pop_velocity=w*pop_velocity+c_self*rand()*(lbest_position-pop_position)+c_social*rand()*(gb_pos-pop_position);
    temp_velocity=pop_velocity;
    pop_velocity(pop_velocity>v_max1)=v_max1;
    pop_velocity(pop_velocity<-v_max1)=-v_max1;
    temp_velocity(temp_velocity>v_max2)=v_max2;
    temp_velocity(temp_velocity<-v_max2)=-v_max2;
    pop_velocity(2,:)=temp_velocity(2,:);
    pop_position=pop_position+pop_velocity;
    disp(sprintf('iteration= %d ', iter));
end

disp(' ');
disp(' ');
disp(['Best fit parameters: x1=',num2str(gbest_current_position(1)),', x2=',num2str(gbest_current_position(2))]);
disp(['Best fitness: ',num2str(gbest_fitness(step_max))]);
plot([1:step_max],gbest_fitness);












