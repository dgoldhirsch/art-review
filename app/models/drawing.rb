class Drawing < ActiveRecord::Base
  belongs_to :artist
  has_many :reviews

  def self.for_review_by(artist_id, sql = :bd)
    find_by_sql(self.send(sql, artist_id))
  end

  private

  def self.bd(artist_id)
    <<-EOF
      SELECT drr.id
      FROM
        (
          SELECT d1.id, 0 AS count
          FROM drawings d1
            LEFT JOIN reviews r1 ON r1.drawing_id = d1.id
          WHERE d1.artist_id <> #{artist_id} AND r1.id IS NULL
          UNION
          (
            SELECT d.id, COUNT(*) AS count
            FROM drawings d
              INNER JOIN reviews r ON r.drawing_id = d.id
            WHERE d.artist_id <> #{artist_id}
            GROUP BY d.id
          )
        ) AS drr
      LEFT JOIN
        (
          SELECT DISTINCT d.id
          FROM drawings d
            INNER JOIN reviews r ON r.drawing_id = d.id
              AND r.artist_id = #{artist_id}
        ) mr ON mr.id = drr.id
      WHERE mr.id IS NULL
      ORDER BY drr.count ASC
    EOF
  end

  def self.cc(artist_id)
    <<-EOF
      select d.id,
        count(*) as number_reviews
      from drawings d left join reviews r on r.drawing_id = d.id
      where d.artist_id <> #{artist_id}
      group by d.id
      having count(*) filter(where(r.artist_id = #{artist_id})) = 0
      order by number_reviews ASC
    EOF
  end
end
