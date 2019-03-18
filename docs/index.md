---
layout: default
---

# Introduction

This project attempts to explore and provide a simple implementation of
the main principles of genetic algorithms. These principles being
population, selection and mutation.

## Sample Simulation:

<video width="640" height="400" controls>
    <source src="final_demo.mp4" type="video/mp4" />
    Your browser does not support the video tag.
</video>

Organisms, indicated by the red circles, compete with other organisms for
food. Food is represented by small green circles and determines an organism's fitness. The more food an organism consumes, the more fit it is. The fittest organisms have the highest chance of reproducing.

Although organisms which consume more food have a higher chance of appearing in the next generation, this is not guaranteed. This program uses a Roulette
Wheel Selection algorithm to determine which organism is selected after
the feeding period. Organisms that are unable to consume any food, immediately die off and do not appear in the next generation.

Each time the feeding phase is over and organisms are selected for the
next generation, there is a slight chance of mutation. The frequency of
mutation is determined by the mutation rate which is represented by the following constant:

```js
/*
Mutation rate is the likelihood a mutation will occur, 
represented by a percentage
*/

// Sets the mutation rate to 10
const MUTATION_RATE = 10;
```
