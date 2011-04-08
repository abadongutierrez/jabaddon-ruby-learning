
DEBUG = 1        
         
nombreArchivoLog = ARGV[0]
if nombreArchivoLog === nil || nombreArchivoLog.strip.length === 0
  puts "Falta especificar el archivo del log a dividir."
else
  aFile = File.open(nombreArchivoLog);
  lines = aFile.readlines

  hash = Hash.new
  fileUsed = "inicio.log"

  lines.each do |aLine|
    #puts "#{aLine}"
    print "."
    if aLine.length > 57
      thread = aLine.slice(30, 27)
      inicio = thread[0]
      fin = thread[-1]
      subthread = thread.slice(1..-2).strip
      if inicio === 91 && fin === 93
        #puts "Es = #{aLine}"
        if hash[thread] === nil
          #puts "#{thread} no existe aun"
          subthread1 = subthread.sub(" ", "_")
          subthread2 = subthread1.sub(" ", "_")
          subthread3 = subthread2.sub(":", "-")
          fileUsed = "#{subthread3}.log"
          hash[thread] = fileUsed
        else
          #puts "#{thread} ya existe"
          fileUsed = hash[thread]
        end
      else
        #puts "No es = #{aLine}"
      end
    end
    newFile = File.open(fileUsed, "a+")
    newFile.syswrite(aLine)
  end

  puts ""
  hash.keys.each do |item|
    #puts "[#{item}] = #{hash[item]}"
  end              
end