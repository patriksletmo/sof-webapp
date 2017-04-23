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

  GROUPS = {
      0 => 'All',
      1 => 'SOF Organisation',
      2 => 'Orchestra Member',
      3 => 'Orchestra Leader',
      4 => 'Funkis',
      5 => 'Cortege Member',
      6 => 'Cortege Leader',
      7 => 'SOF Oldies'
  }

  def map_permissions(user)
    admin_permissions = user['admin_permissions']
    PERMISSIONS.map do |key, value|
      {
          id: "admin_permission[#{key}]",
          name: value,
          given: is_given?(admin_permissions, key)
      }
    end
  end

  def map_groups(user)
    groups = user['usergroup']
    GROUPS.map do |key, value|
      {
          id: "group[#{key}]",
          name: value,
          given: is_given?(groups, key)
      }
    end
  end

  def given_permissions(user)
    admin_permissions = user['admin_permissions']
    human_permissions(admin_permissions)
  end

  def human_permissions(permissions)
    if permissions.present?
      given = []
      PERMISSIONS.each do |key, value|
        if is_given?(permissions, key)
          given.append(value)
        end
      end

      given.join(', ')
    else
      'Inga'
    end
  end

  def is_given?(permissions, permission)
    permissions & (1 << permission) > 0
  end
end
