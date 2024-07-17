WITH
  tabel AS (
    SELECT
    DISTINCT
      A.masked_user_id,
      A.search_count,
      A.view_pdp_count,
      A.view_microsite_count,
      A.session_start_global_count,
      A.wishlist_count,
      A.input_kode_promo_count,
      A.pilih_metode_pembayaran_count,
      A.is_make_order,
      B.city
    FROM `RPEcommerce.database.activity` AS A
    INNER JOIN `RPEcommerce.database.user`AS B
    ON A.masked_user_id = B.masked_user_id
  ),
  pembeli AS (
    SELECT city,
      COUNT(DISTINCT masked_user_id) AS beli
    FROM
      tabel
    WHERE
      is_make_order IS TRUE
      AND pilih_metode_pembayaran_count !=0
      AND view_pdp_count !=0
      AND session_start_global_count >= 1
      AND view_microsite_count != 0
    GROUP BY city
  ),
  pengunjung AS (
    SELECT city,
      COUNT(DISTINCT masked_user_id) AS kunjung
    FROM
      tabel
    WHERE
      session_start_global_count >=1
    GROUP BY city
  ),
  tabel_kota AS (
    SELECT
      V.city,
      B.beli,
      V.kunjung
    FROM pengunjung AS V
    INNER JOIN pembeli AS B
    ON V.city = B.city
  )

SELECT
  tabel_kota.city,
  (tabel_kota.beli / tabel_kota.kunjung) * 100 AS conversion_rate
FROM tabel_kota
ORDER BY 1
