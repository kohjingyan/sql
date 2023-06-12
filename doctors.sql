SELECT d1.* 
FROM doctors d1
JOIN doctors d2 ON d1.id != d2.id
AND d1.hospital = d2.hospital
AND d1.speciality != d2.speciality;