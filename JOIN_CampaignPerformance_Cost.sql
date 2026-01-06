SELECT 
    marketing_campaigns.campaign_id,
    marketing_campaigns.campaign_name,
    SUM(marketing_campaign_performance.cost) AS total_cost,
    SUM(marketing_campaign_performance.conversions) AS total_conversions,
    SUM(marketing_campaign_performance.impressions) AS total_impressions,
    SUM(marketing_campaign_performance.clicks) AS total_clicks,
    (SUM(marketing_campaign_performance.clicks)::decimal 
        / NULLIF(SUM(marketing_campaign_performance.impressions), 0)) AS ctr
FROM marketing_campaigns
JOIN marketing_campaign_performance 
    ON marketing_campaigns.campaign_id = marketing_campaign_performance.campaign_id
GROUP BY 
    marketing_campaigns.campaign_id,
    marketing_campaigns.campaign_name
ORDER BY 
    marketing_campaigns.campaign_id;
