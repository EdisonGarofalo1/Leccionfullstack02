USE [backend001]
GO
/****** Object:  Table [dbo].[persona]    Script Date: 3/5/2024 20:29:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[persona](
	[id_persona] [int] IDENTITY(1,1) NOT NULL,
	[apellidos] [varchar](60) NULL,
	[fecha_nacimiento] [date] NULL,
	[identificacion] [varchar](10) NULL,
	[nombres] [varchar](60) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_persona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rol]    Script Date: 3/5/2024 20:29:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rol](
	[id_rol] [int] IDENTITY(1,1) NOT NULL,
	[rol_name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rol_opciones]    Script Date: 3/5/2024 20:29:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rol_opciones](
	[id_opcion] [int] IDENTITY(1,1) NOT NULL,
	[nombre_opcion] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_opcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rol_rol_opciones]    Script Date: 3/5/2024 20:29:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rol_rol_opciones](
	[rol_id_rol] [int] NOT NULL,
	[rol_opciones_id_opcion] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rol_usuarios]    Script Date: 3/5/2024 20:29:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rol_usuarios](
	[usuario_id_usuario] [int] NOT NULL,
	[rol_id_rol] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sesion]    Script Date: 3/5/2024 20:29:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sesion](
	[id_sesion] [int] IDENTITY(1,1) NOT NULL,
	[fecha_cierre] [date] NULL,
	[fecha_ingreso] [date] NULL,
	[usuarios_id_usuario] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sesion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 3/5/2024 20:29:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuarios](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[intentos_fallidos] [int] NULL,
	[mail] [varchar](120) NULL,
	[password] [varchar](50) NULL,
	[session_active] [varchar](1) NULL,
	[status] [varchar](20) NULL,
	[user_name] [varchar](50) NULL,
	[persona_id_persona2] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[rol_rol_opciones]  WITH CHECK ADD  CONSTRAINT [FKdp7vgtfjv2orqa1slqfms2cpv] FOREIGN KEY([rol_id_rol])
REFERENCES [dbo].[rol] ([id_rol])
GO
ALTER TABLE [dbo].[rol_rol_opciones] CHECK CONSTRAINT [FKdp7vgtfjv2orqa1slqfms2cpv]
GO
ALTER TABLE [dbo].[rol_rol_opciones]  WITH CHECK ADD  CONSTRAINT [FKfthds7uq0l3vd7acafi2l5p2m] FOREIGN KEY([rol_opciones_id_opcion])
REFERENCES [dbo].[rol_opciones] ([id_opcion])
GO
ALTER TABLE [dbo].[rol_rol_opciones] CHECK CONSTRAINT [FKfthds7uq0l3vd7acafi2l5p2m]
GO
ALTER TABLE [dbo].[rol_usuarios]  WITH CHECK ADD  CONSTRAINT [FKbwq10d35yvo19c5wlrc2857mf] FOREIGN KEY([rol_id_rol])
REFERENCES [dbo].[rol] ([id_rol])
GO
ALTER TABLE [dbo].[rol_usuarios] CHECK CONSTRAINT [FKbwq10d35yvo19c5wlrc2857mf]
GO
ALTER TABLE [dbo].[rol_usuarios]  WITH CHECK ADD  CONSTRAINT [FKp26o5netbmvqmdh3cd20jupc5] FOREIGN KEY([usuario_id_usuario])
REFERENCES [dbo].[usuarios] ([id_usuario])
GO
ALTER TABLE [dbo].[rol_usuarios] CHECK CONSTRAINT [FKp26o5netbmvqmdh3cd20jupc5]
GO
ALTER TABLE [dbo].[sesion]  WITH CHECK ADD  CONSTRAINT [FKkj5bitc2nja5frtl60avxbth9] FOREIGN KEY([usuarios_id_usuario])
REFERENCES [dbo].[usuarios] ([id_usuario])
GO
ALTER TABLE [dbo].[sesion] CHECK CONSTRAINT [FKkj5bitc2nja5frtl60avxbth9]
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD  CONSTRAINT [FKp272gbvrce10jrry0usroxllm] FOREIGN KEY([persona_id_persona2])
REFERENCES [dbo].[persona] ([id_persona])
GO
ALTER TABLE [dbo].[usuarios] CHECK CONSTRAINT [FKp272gbvrce10jrry0usroxllm]
GO
/****** Object:  StoredProcedure [dbo].[sp_rol_save]    Script Date: 3/5/2024 20:29:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_rol_save]
    @p_id_rol INT,
    @p_rolName VARCHAR(50),
    @p_opcionesList NVARCHAR(MAX)
AS
BEGIN
    DECLARE @done INT = 0;
    DECLARE @J_mensaje VARCHAR(100);
    DECLARE @J_idOpcion INT;
    DECLARE @idx INT = 0;
    DECLARE @json NVARCHAR(MAX);

    -- Crear tabla temporal para almacenar opciones
    CREATE TABLE #tmp_opcione (
        idOpcion INT
    );

    -- Insertar opciones no nulas en la tabla temporal
    WHILE @done = 0
    BEGIN
        SELECT @json = JSON_VALUE(@p_opcionesList, CONCAT('$[', @idx, '].idOpcion'));
        IF @json IS NOT NULL
        BEGIN
            SET @J_idOpcion = CAST(@json AS INT);
            INSERT INTO #tmp_opcione (idOpcion) VALUES (@J_idOpcion);
        END
        SET @idx = @idx + 1;
        IF LEN(@p_opcionesList) <= @idx
            SET @done = 1;
    END

    IF @p_id_rol IS NOT NULL
    BEGIN
        IF EXISTS (SELECT 1 FROM rol WHERE id_rol = @p_id_rol)
        BEGIN
            -- Actualizar el nombre del rol
            UPDATE rol SET rol_name = @p_rolName WHERE id_rol = @p_id_rol;

            -- Eliminar las relaciones anteriores del rol con las opciones
            DELETE FROM rol_rol_opciones WHERE rol_id_rol = @p_id_rol;

            -- Insertar las asociaciones no nulas en la tabla de opciones
            INSERT INTO rol_rol_opciones (rol_opciones_id_opcion, rol_id_rol)
            SELECT idOpcion, @p_id_rol FROM #tmp_opcione WHERE idOpcion IS NOT NULL;

            -- Limpiar la tabla temporal
            DROP TABLE #tmp_opcione;
            SET @J_mensaje = CONCAT('rol actualizado exitosamente con ID: ', @p_id_rol);
        END
        ELSE
        BEGIN
            SET @J_mensaje = CONCAT('rol no encontrado con el ID: ', @p_id_rol);
        END
    END
    ELSE
    BEGIN
        -- Insertar el rol y obtener su ID
        INSERT INTO rol (rol_name) VALUES (@p_rolName);
        DECLARE @lastIdRol INT = SCOPE_IDENTITY();

        -- Insertar las asociaciones no nulas en la tabla de opciones
        INSERT INTO rol_rol_opciones (rol_opciones_id_opcion, rol_id_rol)
        SELECT idOpcion, @lastIdRol FROM #tmp_opcione WHERE idOpcion IS NOT NULL;

        -- Limpiar la tabla temporal
        DROP TABLE #tmp_opcione;

        SET @J_mensaje = CONCAT('rol guardado exitosamente con ID: ', @lastIdRol);
    END

    SELECT @J_mensaje AS J_mensaje;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_rolfindAll]    Script Date: 3/5/2024 20:29:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_rolfindAll]
AS
BEGIN
    SELECT DISTINCT r.id_rol, r.rol_name, rop.id_opcion, rop.nombre_opcion 
    FROM rol r 
    INNER JOIN rol_rol_opciones op ON r.id_rol = op.rol_id_rol 
    INNER JOIN rol_opciones rop ON rop.id_opcion = op.rol_opciones_id_opcion
    ORDER BY r.id_rol, r.rol_name, rop.id_opcion, rop.nombre_opcion ASC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_rolfindById]    Script Date: 3/5/2024 20:29:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_rolfindById]
    @p_id_rol INT
AS
BEGIN
    SELECT r.id_rol, r.rol_name, rop.id_opcion, rop.nombre_opcion 
    FROM rol r 
    INNER JOIN rol_rol_opciones op ON r.id_rol = op.rol_id_rol 
    INNER JOIN rol_opciones rop ON rop.id_opcion = op.rol_opciones_id_opcion 
    WHERE r.id_rol = @p_id_rol;
END;
GO
