; save screenshot from defined coordinates.

SaveScreenshot(outfile, screen) 
{
   ptoken := gdip_startup()
   raster := 0x40000000 + 0x00cc0020

   pbitmap := gdip_bitmapfromscreen(screen, raster)

   gdip_savebitmaptofile(pbitmap, outfile, 100)
   gdip_disposeimage(pbitmap)
   gdip_shutdown(ptoken)
}
