WITH cte AS (
	SELECT shipment_id, 
	       DATE_FORMAT(shipment_date, '%Y-%m') AS date_ym
	FROM amazon_shipment)
SELECT date_ym, 
       COUNT(shipment_id) AS no_of_shipments
FROM cte
GROUP BY date_ym;
