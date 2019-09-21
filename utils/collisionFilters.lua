filters = {}

filters.player = function(item, other)
  if not (other.properties == nil) and other.properties.collidable then return 'slide' end
  if other.isEnemy then return 'slide' end
end

filters.enemy = function(item, other)
  if not (other.properties == nil) and other.properties.collidable then return 'slide' end
  if other.isPlayer then return 'slide' end
  if other.isEnemy then return 'slide' end
end

filters.bullets = function(item, other)
  if not (other.properties == nil) and other.properties.isWall then return 'bounce' end
  if other.isBullet then return 'touch' end
  if other.isEnemy  and not item.isEnemyBullet then return 'touch' end
  if other.isPlayer and other.visible and item.isEnemyBullet then return 'touch' end
  if other.isMine then return 'touch' end
end

return filters
