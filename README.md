# Ebola-Disease-Prediction
 Stochastic model of the Ebola Virus Disease
The Ebola virus disease(EVD) is an infectious zoonosis found in several mammals, including humans,
bats and apes. A zoonosis is a disease that can be naturally transmitted from animals to humans. The
virus spreads through direct contact with body fluids, such as blood from infected humans or other
animals. Spread may also occur from contact with items recently contaminated with bodily fluids.
Semen or breast milk of a person after recovery from EVD may carry the virus for several weeks to
months. Fruit bats are believed to be the normal carrier in nature, able to spread the virus without
being affected by it. <br><br>
EVD, formerly known as Ebola haemorrhagic fever, is a severe, often fatal illness affecting humans and other
primates. It is one of the most deadliest disease in the world. Its almost 40 years of Ebola disease around
the world and new cases are still being reported in some countries of Africa. So as an initiative to eradicate
it, a model with vaccination is introduced in this project.
<br>
<br>
A stochastic process is defined by the probabilities with which different events happen in a small time
interval. In our model, there are two possible events for each population : production and death/removal.
For a large population size and a large number of infectious individuals, the deterministic threshold Ro >1 provides a good prediction of a disease outbreak.
<br><br>
The compartmental model for EVD included here is an extension of exsisting SEIR(Susceptible,Exposed,Infected
and Recovered) model. It has two additional classes : hospitalized and deceased thus SEIDHR model.
<br><br>

## Assumptions :
1) Each person is equally susceptible to be infected and be cures/die of the disease.
2)The person cannot get the disease again.
3) There aren’t any new people entering or exiting the sample space.
4) The individuals who die in the hospitalized class are immediately buried.
5) The death rate and birth rate are same preserving the number of population.


##  Inference
- Our analytical and numerical results showed that both deterministic and stochastic models predict
disease extinction when Ro < 1. However, the predictions by these models are different when Ro > 1.
In this case, deterministic model predicts with certainty disease outbreak while the stochastic model
has a probability of disease extinction at the beginning of an infection. Hence, with stochastic models,
it is possible to attain a disease-free equilibrium even when Ro > 1. Also, we noticed that initial
conditions do not affect the deterministic threshold while the stochastic thresholds are affected. Thus,
the dynamics of the stochastic model are highly dependent on the initial conditions and should not be
ignored.
- The model has shown success in attempting to predict the causes of Ebola transmission within a population. The model strongly indicated that the spread of a disease largely depends on the contact rates
with infected individuals within a population.
The model also pointed out that early detection has a positive impact on the reduction of ebola
transmission; that is there is a need to detect new cases as early as possible so as to provide early
treatment for the disease.
- It is also realized that if the proportion of the population that is immune exceeds the susceptible
population, then the disease can no longer persist in the population. Thus if this level can be exceeded
by mass vaccination, then the disease can be eliminated.
