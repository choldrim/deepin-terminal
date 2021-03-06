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
    public class CheckButton : Gtk.CheckButton {
		public bool is_hover = false;
		public bool is_press = false;
        public Cairo.ImageSurface checked_hover_surface;
        public Cairo.ImageSurface checked_insensitive_surface;
        public Cairo.ImageSurface checked_normal_surface;
        public Cairo.ImageSurface checked_press_surface;
        public Cairo.ImageSurface unchecked_hover_surface;
        public Cairo.ImageSurface unchecked_insensitive_surface;
        public Cairo.ImageSurface unchecked_normal_surface;
        public Cairo.ImageSurface unchecked_press_surface;
        
        public CheckButton() {
            checked_normal_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path("checkbox_checked_normal.png"));
            checked_hover_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path("checkbox_checked_hover.png"));
            checked_press_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path("checkbox_checked_press.png"));
            checked_insensitive_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path("checkbox_checked_insensitive.png"));
            unchecked_normal_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path("checkbox_unchecked_normal.png"));
            unchecked_hover_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path("checkbox_unchecked_hover.png"));
            unchecked_press_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path("checkbox_unchecked_press.png"));
            unchecked_insensitive_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path("checkbox_unchecked_insensitive.png"));
            
            set_size_request(checked_normal_surface.get_width(), checked_normal_surface.get_height());
            
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
            if (get_sensitive()) {
                if (get_active()) {
                    if (is_press) {
                        Draw.draw_surface(cr, checked_press_surface);
                    } else if (is_hover) {
                        Draw.draw_surface(cr, checked_hover_surface);
                    } else {
                        Draw.draw_surface(cr, checked_normal_surface);
                    }
                } else {
                    if (is_press) {
                        Draw.draw_surface(cr, unchecked_press_surface);
                    } else if (is_hover) {
                        Draw.draw_surface(cr, unchecked_hover_surface);
                    } else {
                        Draw.draw_surface(cr, unchecked_normal_surface);
                    }
                }
            } else {
                if (get_active()) {
                    Draw.draw_surface(cr, checked_insensitive_surface);
                } else {
                    Draw.draw_surface(cr, unchecked_insensitive_surface);
                }
            }
            
            return true;
        }
    }
}