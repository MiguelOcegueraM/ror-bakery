class PostresController < ApplicationController

  @root_url =  "/postres/index"

  layout 'application'

  add_flash_types :notice

  # listar los registros de la db
  def index
    @postres = Postre.all()
  end

  # leer los detalles de un registro en la db
  def leer
    @postres = params[:url]
    @postres = Postre.where(url: @postres)
  end

  def crear
    @postres = Postre.new
  end

  def insertar
    uploaded_file = params[:img]
    File.open(Rails.root.join('public', 'assets/img', uploaded_file.original_filename), 'wb') do |file|
      file.write(uploaded_file.read)
    end

    @postres = Postre.new(parametros)

    # Insercion del registro en la db
    if @postres.save
      @postres.update_column(:img, uploaded_file.original_filename)
    else
      render :new
    end

    # redireccionamos a la vista principal con mensaje
    @ini = "/postres/index"
    flash[:notice] = "Creado Correctamente!"
    redirect_to @ini
  end

  # Llamamos a la vista con el formulario para actualizar un registro

  def actualizar
    # Pasamos el 'id' del registro a actualizar (metodo index)
    @postres = Postre.find(params[:id])
    @postres = Postre.where(id: @postres)
  end

  #Procesamos la actualizacion del registro en la db
  def editar
    # pasamos el id del registro a actualizar
    @postres = Postre.find(params[:id])

    # Actualizamos el archivo al servidor
    uploaded_file = params[:img]

    if params[:img].present?
       # Eliminamos el archivo anterior
       simg = Postre.where(:id => @postres).pluck(:img)
       imgeliminar = Rails.root.join('public', 'assets/img', simg.join)
       File.delete(Rails.root + imgeliminar)

       # Subimos el nuevo archivo
       File.open(Rails.root.join('public', 'assets/img', uploaded_file.original_filename), 'wb') do |file|
         file.write(uploaded_file.read)
       end
    else
      #
    end

    # Actualizamos un determinado registro en la bd
    if @postres.update(parametros)

      # Actualizamos la columna 'img' en la bd
      if params[:img].present?
        @postres.update_column(:img, uploaded_file.original_filename)
      else
        #
      end
    else
      render :edit
    end

    # Redireccionado a la vista principal
    @ini = "/postres/index"
    flash[:notice] = "Actualizado Correctamente!"
    redirect_to @ini
  end

  # Procesamos la eliminacion de un registro en la db
  def eliminar 
    @postres = Postre.find(params[:id])

    # Eliminamos la imagen perteneciente al registro
    simg = Postre.where(:id => @postres).pluck(:img)
    imgeliminar = Rails.root.join('public', 'assets/img', simg.join)
    File.delete(Rails.root + imgeliminar)

    Postre.where(id: @postres).destroy_all

    @ini = "/postres/index"
    flash[:notice] = "Eliminado Correctamente !"
    redirect_to @ini 
  end

  private
  def parametros
    params.permit(:name, :price; :stock, :img, :url)
  end
end
