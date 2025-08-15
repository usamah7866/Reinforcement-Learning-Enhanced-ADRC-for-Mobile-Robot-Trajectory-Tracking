open_system('DDMR_ADRC_LSTM_RL')
load_system('DDMR_ADRC_LSTM_RL')

numObs = 10;
obsInfo = rlNumericSpec([10 1]);
numObservations = obsInfo.Dimension(1);

actInfo = rlNumericSpec([3 1] ,"UpperLimit", [800; 150;50], "LowerLimit", [100; 100;20]);
numAct = 3;
numActions = actInfo.Dimension(1);

env = rlSimulinkEnv('DDMR_ADRC_LSTM_RL','DDMR_ADRC_LSTM_RL/RL Agent',obsInfo,actInfo);
Ts = 1;
Tf = 31;
rng(0);

% Critic Network
statePath = [
    imageInputLayer([numObservations 1 1],'Normalization','none','Name','State')
    fullyConnectedLayer(500,'Name','CriticStateFC1')];

actionPath = [
    imageInputLayer([numActions 1 1],'Normalization','none','Name','Action')
    fullyConnectedLayer(500,'Name','ActionFC1')];

commonPath = [
    additionLayer(2,'Name','add')  % Now both inputs have size 40
    reluLayer('Name','CriticCommonRelu')
    fullyConnectedLayer(1,'Name','CriticOutput')];

criticNetwork = layerGraph();
criticNetwork = addLayers(criticNetwork, statePath);
criticNetwork = addLayers(criticNetwork, actionPath);
criticNetwork = addLayers(criticNetwork, commonPath);
criticNetwork = connectLayers(criticNetwork, 'CriticStateFC1', 'add/in1');
criticNetwork = connectLayers(criticNetwork, 'ActionFC1', 'add/in2');  % Updated to connect ActionFC2

%figure
%plot(criticNetwork)
criticOpts = rlRepresentationOptions('LearnRate',0.0003,'GradientThreshold',1);
critic = rlRepresentation(criticNetwork,obsInfo,actInfo,'Observation',{'State'},'Action',{'Action'},criticOpts);

actorNetwork = [
    imageInputLayer([numObservations 1 1],'Normalization','none','Name','State')
    fullyConnectedLayer(400,'Name','ActorFC1')
    reluLayer('Name','ActorRelu1') 
    fullyConnectedLayer(400,'Name','ActorFC2')
    reluLayer('Name','ActorRelu2') 
    fullyConnectedLayer(numActions,'Name','Action')
    ];

actorOptions = rlRepresentationOptions('LearnRate',0.0001,'GradientThreshold',1);

actor = rlRepresentation(actorNetwork,obsInfo,actInfo,'Observation',{'State'},'Action',{'Action'},actorOptions);
agentOpts = rlDDPGAgentOptions(...
    'SampleTime',Ts,...
    'TargetSmoothFactor',0.001,...
    'DiscountFactor',1, ...
    'MiniBatchSize',128, ...
    'ExperienceBufferLength',1e6);
agentOpts.NoiseOptions.Variance = 0.3;
agentOpts.NoiseOptions.VarianceDecayRate = 1e-4;

agent = rlDDPGAgent(actor,critic,agentOpts);

maxepisodes = 100;
maxsteps = ceil(Tf/Ts);
trainOpts = rlTrainingOptions("MaxEpisodes", maxepisodes, ...
    "MaxStepsPerEpisode", maxsteps, ...
    "ScoreAveragingWindowLength", 5, ...
    "Verbose", true, ...
    "Plots", "training-progress", ...
    "StopOnError", "off", ...
    "StopTrainingCriteria", "AverageReward", ...
    "StopTrainingValue", 10000, ...
    "SaveAgentCriteria", "AverageReward", ...
    "SaveAgentValue", 9960, ...
     "SaveAgentDirectory", 'C:\Users\Dell\Desktop\RA\Mobile robot\savedAgents');

doTraining = true;

if doTraining
    % Train the agent.
    trainingStats = train(agent,env,trainOpts);
    
end
save('TrainedDDPGAgent2.mat', 'agent');
