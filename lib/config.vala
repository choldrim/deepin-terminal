/* -*- Mode: Vala; indent-tabs-mode: nil; tab-width: 4 -*-
 * -*- coding: utf-8 -*-
 *
 * Copyright (C) 2011 ~ 2016 Deepin, Inc.
 *               2011 ~ 2016 Wang Yong
 *
 * Author:     Wang Yong <wangyong@deepin.com>
 * Maintainer: Wang Yong <wangyong@deepin.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */ 

using GLib;
using Gee;

namespace Config {
    public class Config : GLib.Object {
        public ArrayList<string> backspace_key_erase_names;
		public ArrayList<string> del_key_erase_names;
		public ArrayList<string> encoding_names;
		public ArrayList<string> theme_names;
		public HashMap<string, string> erase_map;
		public double default_opacity = 0.9;
		public int default_size = 11;
		public string default_mono_font = "";
        public KeyFile config_file;
        public string config_file_path = Utils.get_config_file_path("config.conf");
        
        public signal void update();
        
        public Config() {
			default_mono_font = font_match("mono");
			
            config_file = new KeyFile();

			theme_names = Utils.list_files(Utils.get_theme_dir());
			
			backspace_key_erase_names = new ArrayList<string>();
			string[] backspace_key_erase_list = {"ascii-del", "auto", "control-h", "escape-sequence", "tty"};
			foreach (string name in backspace_key_erase_list) {
				backspace_key_erase_names.add(name);
			}

			del_key_erase_names = new ArrayList<string>();
			string[] del_key_erase_list = {"escape-sequence", "ascii-del", "auto", "control-h", "tty"};
			foreach (string name in del_key_erase_list) {
				del_key_erase_names.add(name);
			}
			
			erase_map = new HashMap<string, string>();
			erase_map.set("ascii-del", "ascii-del");
			erase_map.set("auto", "auto");
			erase_map.set("control-h", "control-h");
			erase_map.set("escape-sequence", "escape-sequence");
			erase_map.set("tty", "tty");
			
			encoding_names = new ArrayList<string>();
			string[] encoding_list = {"UTF-8", "GB18030", "GB2312", "GBK", "BIG5", "BIG5-HKSCS", "ISO-8859-1",  "ISO-8859-2", "ISO-8859-3", "ISO-8859-4", "ISO-8859-5", "ISO-8859-6", "ISO-8859-7", "ISO-8859-8", "ISO-8859-8-I", "ISO-8859-9", "ISO-8859-10", "ISO-8859-13", "ISO-8859-14", "ISO-8859-15", "ISO-8859-16", "ARMSCII-8", "CP866", "EUC-JP", "EUC-KR", "EUC-TW", "GEORGIAN-PS", "IBM850", "IBM852", "IBM855", "IBM857", "IBM862", "IBM864", "ISO-2022-JP", "ISO-2022-KR", "ISO-IR-111", "KOI8-R", "KOI8-U", "MAC_ARABIC", "MAC_CE", "MAC_CROATIAN", "MAC-CYRILLIC", "MAC_DEVANAGARI", "MAC_FARSI", "MAC_GREEK", "MAC_GUJARATI", "MAC_GURMUKHI", "MAC_HEBREW", "MAC_ICELANDIC", "MAC_ROMAN", "MAC_ROMANIAN", "MAC_TURKISH", "MAC_UKRAINIAN", "SHIFT_JIS", "TCVN", "TIS-620", "UHC", "VISCII", "WINDOWS-1250", "WINDOWS-1251", "WINDOWS-1252", "WINDOWS-1253", "WINDOWS-1254", "WINDOWS-1255", "WINDOWS-1256", "WINDOWS-1257", "WINDOWS-1258"};
			foreach (string name in encoding_list) {
				encoding_names.add(name);
			}
			
            var file = File.new_for_path(config_file_path);
            if (!file.query_exists()) {
                init_config();
            } else {
                load_config();
            }
        }
		
        public void init_config() {
            config_file.set_string("general", "theme", "deepin");
            config_file.set_double("general", "opacity", default_opacity);
            config_file.set_string("general", "font", default_mono_font);
            config_file.set_integer("general", "font_size", default_size);
            
            config_file.set_string("keybind", "copy_clipboard", "Ctrl + Shift + c");
            config_file.set_string("keybind", "paste_clipboard", "Ctrl + Shift + v");
			config_file.set_string("keybind", "search", "Ctrl + Shift + f");
            config_file.set_string("keybind", "zoom_in", "Ctrl + =");
            config_file.set_string("keybind", "zoom_out", "Ctrl + -");
            config_file.set_string("keybind", "revert_default_size", "Ctrl + 0");
            config_file.set_string("keybind", "select_all", "Ctrl + Shift + a");
            
            config_file.set_string("keybind", "new_workspace", "Ctrl + Shift + t");
            config_file.set_string("keybind", "close_workspace", "Ctrl + Shift + w");
            config_file.set_string("keybind", "next_workspace", "Ctrl + Tab");
            config_file.set_string("keybind", "previous_workspace", "Ctrl + Shift + Tab");
            config_file.set_string("keybind", "split_vertically", "Ctrl + h");
            config_file.set_string("keybind", "split_horizontally", "Ctrl + Shift + h");
            config_file.set_string("keybind", "select_up_window", "Alt + k");
            config_file.set_string("keybind", "select_down_window", "Alt + j");
            config_file.set_string("keybind", "select_left_window", "Alt + h");
            config_file.set_string("keybind", "select_right_window", "Alt + l");
            config_file.set_string("keybind", "close_window", "Ctrl + q");
            config_file.set_string("keybind", "close_other_windows", "Ctrl + Shift + q");
            
            config_file.set_string("keybind", "toggle_fullscreen", "F11");
            config_file.set_string("keybind", "show_helper_window", "Ctrl + Shift + ?");
            config_file.set_string("keybind", "show_remote_panel", "Ctrl + /");
            
            config_file.set_string("advanced", "cursor_shape", "block");
            config_file.set_boolean("advanced", "cursor_blink_mode", true);
            
            config_file.set_boolean("advanced", "scroll_on_key", true);
            config_file.set_boolean("advanced", "scroll_on_output", false);
            config_file.set_integer("advanced", "scroll_line", -1);
            config_file.set_string("advanced", "window_state", "window");
            config_file.set_integer("advanced", "window_width", 0);
            config_file.set_integer("advanced", "window_height", 0);
            config_file.set_double("advanced", "quake_window_height", 0);
			
			config_file.set_string("theme", "color_1", "#073642");
			config_file.set_string("theme", "color_2", "#bdb76b");  // string
			config_file.set_string("theme", "color_3", "#859900");
			config_file.set_string("theme", "color_4", "#b58900");
			config_file.set_string("theme", "color_5", "#ffd700");  // path
			config_file.set_string("theme", "color_6", "#d33682");
			config_file.set_string("theme", "color_7", "#2aa198");
			config_file.set_string("theme", "color_8", "#eee8d5");
			config_file.set_string("theme", "color_9", "#002b36");
			config_file.set_string("theme", "color_10", "#8b0000");  // error
			config_file.set_string("theme", "color_11", "#00ff00");  // exec
			config_file.set_string("theme", "color_12", "#657b83");
			config_file.set_string("theme", "color_13", "#1e90ff");  // folder
			config_file.set_string("theme", "color_14", "#6c71c4");
			config_file.set_string("theme", "color_15", "#93a1a1");
			config_file.set_string("theme", "color_16", "#fdf6e3");
			config_file.set_string("theme", "background", "#000000");  // background
			config_file.set_string("theme", "foreground", "#00cd00");  // foreground
			config_file.set_string("theme", "tab", "#2CA7F8");         // tab
			config_file.set_string("theme", "style", "dark");          // style

            save();
        }
        
        public void load_config() {
            try {
                config_file.load_from_file(config_file_path, KeyFileFlags.NONE);
            } catch (Error e) {
				if (!FileUtils.test(config_file_path, FileTest.EXISTS)) {
					print("Config: %s\n", e.message);
				}
			}
        }
        
        public void set_theme(string theme_name) {
            try {
                KeyFile theme_file = new KeyFile();
                theme_file.load_from_file(Utils.get_theme_path(theme_name), KeyFileFlags.NONE);
            
                foreach (string key in theme_file.get_keys("theme")) {
                    config_file.set_string("theme", key, theme_file.get_string("theme", key).strip());
                }
                
                var background = theme_file.get_string("theme", "background").strip();
                if (Utils.is_light_color(background)) {
                    config_file.set_string("theme", "style", "light");
                } else {
                    config_file.set_string("theme", "style", "dark");
                }
            } catch (Error e) {
                print("Config set_theme: %s\n", e.message);
            }
        }
        
        public void save() {
            try {
			    Utils.touch_dir(Utils.get_config_dir());
				
                config_file.save_to_file(config_file_path);
            } catch (GLib.FileError e) {
				if (!FileUtils.test(config_file_path, FileTest.EXISTS)) {
					print("save: %s\n", e.message);
				}
			}
        }
    }
}