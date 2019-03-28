# set file name
out_ps=template.ps
hwFile="hw.csv"
gmt makecpt -Crainbow -T0/1/0.1 -Z > eq.cpt

  
# start gmt session
gmt psxy -R0/1/0/1 -JX1c -T -K -P > $out_ps

gmt psbasemap -R119/123/21/26 -Jm4 -B1 -G152/245/255 -O -K -Y2>> $out_ps
gmt pscoast -R -J -B -W1 -G205/205/193 -Df -Ia -O -K >> $out_ps

echo 121.00 26.50 22,1,black 0 CM UVI MAP | gmt pstext -R -J -F+f+a+j -N -O -K >> $out_ps
awk -F'[,"]' 'NR>1 {print $12":"$13":"$14"E" ,$7":"$8":"$9"N" ,$5 }' $hwFile | gmt psxy -R -J -Sc0.3 -W0.1 -Ceq.cpt -O -K >> $out_ps  
# write your gmt code here
gmt pscoast -R119/123/21/26 -Jm4 -B1 -W1 -Df -Ia -P -O -K >> $out_ps

gmt pslegend -R0/4/0/3.75 -Jm -O -K -DjBL+w1.2i+o0.9i -F+glightgray+pthicker \
	--FONT_ANNOT_PRIMARY=14p,Helvetica-Bold << EOF >> $out_ps
S 0.1i c 0.07i black - 0.3i UVI
EOF

gmt psscale -Ceq.cpt -Dx8c/-1.5c+w12c/0.5c+jTC+h -Bx0.2+l"UVI" -O -K >> $out_ps

# end gmt session
gmt psxy -R -J -O -T >> $out_ps
  
# convert to pdf
gmt psconvert $out_ps -P -Tf
# convert to png
gmt psconvert $out_ps -P -Tg

