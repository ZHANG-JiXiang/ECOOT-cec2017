# ECOOT-cec2017
针对白骨顶鸡优化算法全局搜索能力弱、收敛速度慢、易陷于局部最优的不足，本文提出一种增强型白骨顶鸡优化算法。首先，利用拉丁超立方抽样方法均匀初始化种群，从而改善种群的多样性和算法的全局性能。其次，在跟随领导者的位置更新策略中加入掉队机制，增强算法跳出局部最优能力。最后，引入二次插值策略，提高算法收敛速度与寻优精度。实验使用CEC2017测试函数对算法进行测试比较，测试结果表明改进的算法在精度、收敛速度、稳定性方面优于原算法与六种流行的群智能算法。此外，通过三个实际工程优化问题验证了所提出的增强型白骨顶鸡优化算法的实用性。

title"Enhanced Coot optimization algorithm and its application"

Abstract: In response to the limitations of weak global search capability, slow convergence speed, and susceptibility to local optima in the Coot optimization algorithm(COA), this paper proposes an enhanced Coot optimization algorithm (ECOA).First, Latin hypercube sampling method is used to uniformly initialize the population, which improves the diversity of the initial population and the global performance of the algorithm. Second, the leader-following position update formula of the original algorithm is modified by integrating a dropout mechanism to avoid excessive concentration, which enhances the ability to escape local optima. Finally, a quadratic interpolation strategy is used to improve the algorithm's convergence speed and optimization accuracy. CEC2017 test functions are utilized to evaluate the performance of ECOA, COA, and other six popular swarm intelligence algorithms. Experimental results show that ECOA outperforms the original algorithm and comparison algorithms in terms of accuracy, convergence speed, and stability. In addition, the practical applicability of ECOA is demonstrated by three engineering optimization problems.

#### Experimental results:

![Comparison of statistical results of CEC2017 test functions](https://github.com/ZHANG-JiXiang/ECOOT-cec2017/blob/main/Comparison%20of%20statistical%20results%20of%20CEC2017%20test%20functions.png)

# cite
[1]	张吉祥, 张孟健, 王德光. 增强型白骨顶鸡优化算法及其应用[J]. 小型微型计算机系统, 2024, 45(10): 2401-2410. 
