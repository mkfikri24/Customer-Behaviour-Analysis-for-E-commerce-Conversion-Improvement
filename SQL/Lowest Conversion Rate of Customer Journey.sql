SELECT
  COUNT(DISTINCT view_pdp_count) / (
  SELECT
    COUNT(DISTINCT masked_user_id)
  FROM
    RPEcommerce.database.activity
  WHERE
    session_start_global_count >=1) * 100 AS visitor_pdp,
  COUNT(DISTINCT input_kode_promo_count) / COUNT(DISTINCT view_pdp_count) * 100 AS pdp_code,
  COUNT(DISTINCT pilih_metode_pembayaran_count) / COUNT(DISTINCT input_kode_promo_count) * 100 AS code_metode,
  COUNT(DISTINCT view_pdp_count) / (
  SELECT
    COUNT(DISTINCT masked_user_id)
  FROM
    RPEcommerce.database.activity
  WHERE
    session_start_global_count >=1) * 100 AS lowest_CR_Visitor_to_View_PDP
FROM
  RPEcommerce.database.activity
