# readyaimfire
GovHack 2018 project

Features
========

Before the fire…
 - helps plan survival strategies for the event of a bushfire
 - helps encourage preparation by gamification and social media
 - helps build community resilience by connecting people and developing survival strategies at the community level
 - prompts rehearsal of (and thus familiarity with) then plan 
During a fire
 - helps people to follow their plan and avoid panic
 - provides situational awareness by the dynamic updating of escape routes to reflect a changing situation
 - provides authorities with live information about who has evacuated

Technologies
============

The tool is an R/Shiny web-app. It
 - Integrates mapping data from OpenStreetMap with “Last Refuge” data from the CFS. It uses geocoding to determine the location of a user’s address and calculate the three “best” Last Refuges that can be evacuated to, along with the optimal route to get there.
 - In the finished product, the process to determine the optimal place to evacuate will include risk data that are a composite of known fire danger (BOM dataset), weather (BOM dataset), topography (OpenStreeMaps dataset), road works (DPTI dataset). Thus, a shorter riskier route would be deprioritized versus a longer safer route.
 - The finished product would also use social media to provide notifications to friends/neighbours about actions taken to prepare for (and in the event of) a bushfire.

