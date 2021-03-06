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

using Gtk;
using Widgets;

namespace Widgets {
    public class AddServerButton : Gtk.EventBox {
		public bool is_hover = false;
		public bool is_press = false;
        public Cairo.ImageSurface hover_dark_surface;
        public Cairo.ImageSurface hover_light_surface;
        public Cairo.ImageSurface normal_dark_surface;
        public Cairo.ImageSurface normal_light_surface;
        public Cairo.ImageSurface press_dark_surface;
        public Cairo.ImageSurface press_light_surface;
        public Gdk.RGBA hover_dark_color;
        public Gdk.RGBA hover_light_color;
        public Gdk.RGBA press_dark_color;
        public Gdk.RGBA press_light_color;
        public Gdk.RGBA text_hover_color;
        public Gdk.RGBA text_normal_color;
        public Gdk.RGBA text_press_color;
        public int height = 56;
        public int image_x = 12;
        public int text_size = 11;
        public int text_x = 72;
        public int width = Constant.SLIDER_WIDTH;
        public string button_text = "add server";
        
        public AddServerButton() {
            Intl.bindtextdomain(GETTEXT_PACKAGE, "/usr/share/locale");
            button_text = _("Add server");
            
            var image_path = "add_server";
			normal_dark_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path(image_path + "_dark_normal.png"));
            hover_dark_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path(image_path + "_dark_hover.png"));
            press_dark_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path(image_path + "_dark_press.png"));
			normal_light_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path(image_path + "_light_normal.png"));
            hover_light_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path(image_path + "_light_hover.png"));
            press_light_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path(image_path + "_dark_press.png"));
            
            if (button_text != null) {
                text_normal_color = Utils.hex_to_rgba("#0699FF");
                text_hover_color = Utils.hex_to_rgba("#6DC5FF");
                text_press_color = Utils.hex_to_rgba("#2ca7f8");
            }
            
            press_dark_color = Utils.hex_to_rgba("#FFFFFF", 0.1);
            hover_dark_color = Utils.hex_to_rgba("#FFFFFF", 0.1);
            press_light_color = Utils.hex_to_rgba("#000000", 0.1);
            hover_light_color = Utils.hex_to_rgba("#000000", 0.1);
            
            set_size_request(width, height);
            
            draw.connect(on_draw);
			enter_notify_event.connect((w, e) => {
					is_hover = true;
					queue_draw();
					
					return false;
				});
			leave_notify_event.connect((w, e) => {
					is_hover = false;
					queue_draw();
					
					return false;
				});
			button_press_event.connect((w, e) => {
					is_press = true;
					queue_draw();
					
					return false;
				});
			button_release_event.connect((w, e) => {
					is_press = false;
					queue_draw();
					
					return false;
				});
        }
        
        private bool on_draw(Gtk.Widget widget, Cairo.Context cr) {
            bool is_light_theme = ((Widgets.ConfigWindow) get_toplevel()).is_light_theme();
            
            if (is_press) {
                if (is_light_theme) {
                    Draw.draw_surface(cr, press_light_surface, image_x, 0, 0, height);
                } else {
                    Draw.draw_surface(cr, press_dark_surface, image_x, 0, 0, height);
                }
                if (button_text != null) {
                    Utils.set_context_color(cr, text_press_color);
                    Draw.draw_text(cr, button_text, text_x, 0, width, height, text_size);
                }
            } else if (is_hover) {
                if (is_light_theme) {
                    Draw.draw_surface(cr, hover_light_surface, image_x, 0, 0, height);
                } else {
                    Draw.draw_surface(cr, hover_dark_surface, image_x, 0, 0, height);
                }
                if (button_text != null) {
                    Utils.set_context_color(cr, text_hover_color);
                    Draw.draw_text(cr, button_text, text_x, 0, width, height, text_size);
                }
            } else {
                if (is_light_theme) {
                    Draw.draw_surface(cr, normal_light_surface, image_x, 0, 0, height);                
                } else {
                    Draw.draw_surface(cr, normal_dark_surface, image_x, 0, 0, height);                
                }
                if (button_text != null) {
                    Utils.set_context_color(cr, text_normal_color);
                    Draw.draw_text(cr, button_text, text_x, 0, width, height, text_size);
                }
            }
            
            if (is_press) {
                if (is_light_theme) {
                    Utils.set_context_color(cr, press_light_color);
                } else {
                    Utils.set_context_color(cr, press_dark_color);
                }
                Draw.draw_rectangle(cr, 0, 0, width, height);
            } else if (is_hover) {
                if (is_light_theme) {
                    Utils.set_context_color(cr, hover_light_color);
                } else {
                    Utils.set_context_color(cr, hover_dark_color);
                }
                Draw.draw_rectangle(cr, 0, 0, width, height);
            }
            
           return true;
        }
    }
}