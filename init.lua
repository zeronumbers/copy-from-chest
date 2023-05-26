--[[
  copy-from-chest mod that adds a server command to copy items from chest to inventory of player.
  Copyright (C) 2023  Vladislav Morozov

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
]]

minetest.register_chatcommand(
	'copy-from-chest',
	{
		description = 'Copies items from chest at <x> <y> <z> to the <player>.\nThe chest must be loaded\nIf once is provided does not give item when it is already in inventory of player.\nDoes not give item when there is no space for it.\nIt would try to fit as many items as possible in inventory in the case when there is no space for all items.\nRelative numbers for coordinates of chest (x y z) are not supported.\nShows default warning when you try to use chest that is not loaded in game',
		params = '<x> <y> <z> <player> [once]',
		privs = {server = true},
		func = function(name, param)
			local param_list = param:split(' ')
			local x = tonumber(param_list[1])
			local y = tonumber(param_list[2])
			local z = tonumber(param_list[3])
			local player_name = param_list[4]
      local once = param_list[5]

			if x and y and z then
				-- recieving player, not the one who issues command
				local player = minetest.get_player_by_name(player_name)
				local chest_inv = minetest.get_inventory({type='node', pos={x=x, y=y, z=z}})

				if player and chest_inv then
					local player_inv = minetest.get_inventory({type='player', name=player_name})
					local chest_items = chest_inv:get_list('main')

					for _, stack in ipairs(chest_items) do
						if stack:get_count() > 0 then
							local has_space = player_inv:room_for_item('main', stack)
							local has_item = player_inv:contains_item('main', stack)

							local item_name = stack:get_name()

							if not has_space then
								minetest.chat_send_player(player_name, 'Not enough room for: ' .. item_name)
							end

							if has_item and once then
								minetest.chat_send_player(player_name, 'You already have: '.. item_name)
							end

							-- this could be avoided if lua had continue like in js
							if ((once and not has_item) and has_space) or (has_space and not once) then
								player_inv:add_item('main', stack)
							end
						end
					end
				end
				return true
			end
		end
	}
)
