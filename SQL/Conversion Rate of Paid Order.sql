SELECT
  (
  SELECT
    COUNT(DISTINCT masked_user_id)
  FROM
    RPEcommerce.database.activity
  WHERE
    is_make_order IS TRUE
    AND pilih_metode_pembayaran_count !=0
    AND view_pdp_count !=0
    AND session_start_global_count >= 1
    AND view_microsite_count != 0) AS total_complete_transaction,
  (
  SELECT
    COUNT(DISTINCT masked_user_id)
  FROM
    RPEcommerce.database.activity
  WHERE
    session_start_global_count >=1) AS total_visitor,
  (
  SELECT
    COUNT(DISTINCT masked_user_id)
  FROM
    RPEcommerce.database.activity
  WHERE
    is_make_order IS TRUE
    AND pilih_metode_pembayaran_count !=0
    AND view_pdp_count !=0
    AND session_start_global_count >= 1
    AND view_microsite_count != 0) / (
  SELECT
    COUNT(DISTINCT masked_user_id)
  FROM
    RPEcommerce.database.activity
  WHERE
    session_start_global_count >=1) * 100 AS conversion_rate
