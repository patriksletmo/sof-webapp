module UserManagementHelper
  PERMISSIONS = {
      0 => 'All',
      1 => 'List orchestra signups',
      2 => 'Modify available articles',
      3 => 'List users',
      4 => 'Modify users',
      5 => 'Delete users',
      6 => 'List cortege applications',
      7 => 'Approve cortege applications',
      8 => 'List funkis applications',
  }

  def map_permissions(user)
    permissions = user['permissions']
    PERMISSIONS.map do |key, value|
      {
          id: "permission[#{key}]",
          name: value,
          given: is_given?(permissions, key)
      }
    end
  end

  def given_permissions(user)
    permissions = user['permissions']
    given = []
    PERMISSIONS.each do |key, value|
      if is_given?(permissions, key)
        given.append(value)
      end
    end

    given.join(', ')
  end

  def is_given?(permissions, permission)
    permissions & (1 << permission) > 0
  end
end
