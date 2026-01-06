SELECT 
    campaign_id,
    campaign_name,
    target_audience,
    channel,
    start_date,
    end_date,
    goal
FROM marketing_campaigns;


SELECT 
    campaign_id,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks
FROM marketing_campaign_performance
GROUP BY campaign_id;



