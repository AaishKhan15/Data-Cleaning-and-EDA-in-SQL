## Insights derived from the Dataset
Across the ~3 year period covered by this dataset (March 2020 – March 2023), companies laid off a combined 383,659 employees, despite these companies having collectively 
raised over $1.6 trillion in funding, with an average of 26% of staff laid off per company event.

#### Layoffs spiked roughly 10x almost overnight
Layoffs stayed relatively low through 2021, totaling 15,823 for the year. In 2022, that number jumped to 160,661 (roughly a 10x increase) and the trend didn't
slow down when entering 2023: the first three months of 2023 alone already equalled to 125,677, which is more than half of all of 2022's layoffs in just a fraction of the time.

This timing lines up closely with what's commonly referred to as the 2022 "tech correction." Through 2020–2021, interest rates were kept near zero during pandemic to push economic activity after it came to a standstill, and make it easier for companies to access cheap capital to remain afloat. The near zero interest rate caused investors to shift their attention from bonds to stocks to get any meaningful return. Venture capital flowed freely into tech and startup companies, many of which followed a "grow now, profit later" strategy, raising large funding rounds and spending aggressively on hiring and expansion.

Starting in 2022, central banks raised interest rates sharply to combat inflation. 
This had a ripple effect: safer investments (like bonds) suddenly offered decent returns, so investors pulled back from funding unprofitable, high growth startups as they realized lack of cheap capital meant lack of growth.
Public tech stock valuations dropped as higher interest rate lowered the Present Value the company promised to make 10 years from now.

Companies that had scaled up headcount during the low interest rate period were forced to cut costs quickly and payroll, often a company's largest expense, was the first lever pulled. This is a widely cited explanation for the layoff wave seen through 2022–2023 more broadly and offers a plausible explanation for the timing observed here.


#### Funding and Maturity didnt protect against layoffs
One might assume that companies with large amounts of funding, or those further along in their lifecycle (e.g. post-IPO), would be more protected from layoffs as more capital should mean more room to absorb downturns. The data doesn't support that assumption.

- No meaningful correlation was found between funds raised and total layoffs, companies that had raised hundreds of millions or even billions in funding still went through major layoffs, in some cases laying off 100% of staff entirely.
  
- This pattern was seen at the company stage level too: Post-IPO companies had both the highest total layoffs and the largest number of affected companies of any stage category, ahead of earlier stage startups (Series A/B/C, etc.). This is a bit counterintuitive, since Post-IPO companies are typically the most mature, most heavily capitalized, and often assumed to be the "safest" category.

Together, these two findings suggest that capital and maturity didn't function as a safety net during this period, if anything, some of the largest, most well funded, most established companies cut the deepest, likely because they had scaled headcount the most aggressively during the low interest rate years.

#### Concentration vs Distribution Pattern
Looking at the top 5 countries by total layoffs, the raw totals only tell part of the story, how those layoffs were spread out matters just as much.

- The US had the highest total layoffs by a wide margin, but this was distributed across a large number of companies. 1,294 distinct companies had at least one layoff event. This suggests the layoffs reflect a broad, industry wide trend rather than being driven by a handful of large events. Within the US, the highest layoffs came from Consumer, Retail, and Transportation, consistent with the demand reversal pattern discussed below.
- Netherlands and Sweden, by contrast, had layoffs that were concentrated in just 12–17 companies each. This is a very different shape of impact: a small number of companies in these countries had severe layoff events, rather than the effect being spread broadly across the local economy. Notably, the industries driving this were different from the US: Healthcare led in the Netherlands, while "Other" led in Sweden, suggesting that their impact came from a distinct, localized cause rather than the same broad Consumer/Retail pattern seen in the US.

In short: the US pattern looks like "a widespread trend affecting many companies a little," while the Netherlands/Sweden pattern looks more like "a few companies affected a lot." Both produce large layoff numbers, but the the implications for the local labor market are quite different.

#### Consumer and Retail bore the brunt
Consumer and Retail were the hardest-hit industries by total layoffs, ahead of every other category in the dataset.

A plausible explanation for this could be a shift in consumer demand during and after the pandemic. During 2020–2021, with people stuck at home and many in person options unavailable, spending shifted heavily toward physical goods and e-commerc; online retail, delivery services, home goods, and similar categories saw a big demand spike . Companies in these spaces often treated this surge as a long term shift in behavior rather than a temporary one, and scaled up hiring, warehousing, and delivery infrastructure to match.

As pandemic restrictions eased and people returned to in person shopping, dining, and travel, thr previoud elevated demand for goods didn't hold and spending patterns partially reverted back to pre-pandemic patterns. Companies that had staffed up for the pandemic-era demand level found themselves overstaffed, which contributed to the wave of layoffs seen in Consumer and Retail through 2022–2023.

#### Repeated layoff rounds
Among the top affected countries, the US and India stood out for having the highest number of companies that went through multiple separate layoff rounds over the 3 year period, rather than a single one time event.

This suggests that for some companies, layoffs weren't a single "correction" but an ongoing process of downsizing, potentially reflecting prolonged uncertainty or repeated attempts to reach a sustainable headcount rather than one clean cut.

#### Big companies, big layoffs, but does size still mean job security?
The five companies with the highest total layoffs over the period were Amazon, Google, Meta, Salesforce, and Microsoft, some of the largest and most established technology companies in the world.

Interestingly, these layoffs weren't evenly spread across the timeline: Amazon and Meta's largest layoffs were concentrated in 2022, while Google, Salesforce, and Microsoft's peak layoffs came in 2023. This suggests a kind of "wave" effect, the layoff pressure moved through different major companies at different points, rather than all five cutting staff simultaneously.

More broadly, this raises a reasonable question: does working at a large, established tech company still imply strong job security? Historically, large, profitable companies were seen as safer employers than early stage startups. This dataset suggests that assumption weakened during this period, some of the largest, most recognizable companies in tech had the highest layoff counts in the dataset. That said, it's worth noting that large companies also have far larger total headcounts to begin with, so a large absolute layoff number doesn't necessarily mean a large percentage of their workforce was affected, a nuance worth exploring further if the dataset had a total employees column.
