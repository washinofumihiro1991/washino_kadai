function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%


%%%1.3
Y = eye(num_labels)(y, :);
% Y = zeros(m, num_labels);
% for i = 1:m
% Y(i,y(i)) = 1;
% endfor 


%[5000, 400]
a1 = X;

z2 = [ones(m, 1), a1] * Theta1';
a2 = sigmoid(z2);
z3 = [ones(m, 1), a2] * Theta2';
h = sigmoid(z3);

% cost function
cost = -Y .* log(h) - (1-Y) .* log(1-h);
%1.row, 2.col
sum_cost = sum(cost, 2);
J = (1/m) * sum(sum_cost);

%%%%%%%%%%%%%%%


%%%1.4
lambda = 1;

theta1_norm = Theta1(: , 2:end);
theta2_norm = Theta2(: , 2:end);

sum_theta1_norm = sumsq(theta1_norm);
sum_theta2_norm = sumsq(theta2_norm);

reg = lambda / (2 * m) * (sum(sum_theta1_norm) + sum(sum_theta2_norm));
J = J + reg;


%%%%
%nnCostFunction.m

delta1 = 0.0;
delta2 = 0.0;

%grad
for i = 1:m
a1 = [1; X(m, :)']; %[401, 1]

%Theta1[25, 401]
z2 = Theta1 * a1; %[25, 1]
a2 = [1; sigmoid(z2)]; %[26, 1]

%Theta2[10, 26]
z3 = Theta2 * a2; %[10, 1] 
a3 = sigmoid(z3); %[10, 1]

% Y(m, :)[1, 10]
delta_layer3 = a3 - Y(m, :)'; %[10, 1]

% theta2_norm[10, 25] delta_layer3[10, 1]
% sigmoidGradient(z2)[1, 25]
delta_layer2 = theta2_norm' * delta_layer3 .* sigmoidGradient(z2);

delta2 = delta2 + delta_layer3 * a2';
delta1 = delta1 + delta_layer2 * a1'; 

endfor



Theta1_grad(:, 2:end) = Theta1_grad(:, 2:end) + ((lambda / m) * theta1_norm);
Theta2_grad(:, 2:end) = Theta2_grad(:, 2:end) + ((lambda / m) * theta2_norm);






% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
