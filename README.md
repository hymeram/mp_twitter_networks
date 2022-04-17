# MPs' Twitter Networks 
Twitter's API can be used to collect data on how politicians interact with each other and other users on the platform. This data an be used to study their behavior and political preferences.

The code contained here is the cleaned up version of some of the code I used for my master's dissertation. This dissertation looked at how ideology and factional membership influence how MPs interact with each other on Twitter.

### MPs' Twitter Like Network 
The python script 'tweet_like_visualisation' collects the data using Twitters API and visualizes the network. the thickness of the edges indicate the number of times the MPs have liked each others tweets and colour indicates party membership.

![alt text](https://github.com/hymeram/mp_twitter_networks/blob/main/like_network.png)

### Analysing the Network 
The dataset 'like_matrix.csv' shows the likes each MP gave each other over a period in 2020 and 2021. This data can then be used to analyse their behaviour. To give a simple example the R script 'lsm_ideology_estimation' condenses the data into two dimensional latent space where the positions of the MPs can be used to infer their ideological distance from one another.

![alt text](https://github.com/hymeram/mp_twitter_networks/blob/main/MP_latent_space_plot.png) 

The above shows MPs positions in latent space. MPs tend to interact more with other members of their party and are hence close in latent space. MPs from parties who are ideologically similar are also closely positioned in latent space.DUP MPs for example are positioned close to Conservative MPs.