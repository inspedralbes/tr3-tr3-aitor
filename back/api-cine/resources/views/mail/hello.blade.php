<!DOCTYPE html>
<html>
<head>
    <title>Detalles de tu Entrada</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1, h2, p {
            margin: 0 0 20px;
        }
        .footer {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #ccc;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Hola {{ $usuario->nom }},</h1>
        <p>Tengo el placer de informarte que has adquirido una entrada para la película <strong>{{ $pelicula->titulo }}</strong>.</p>
        <p>A continuación, encontrarás los detalles de tu entrada:</p>

        <h1>Detalles de tu Entrada</h1>
        
        <!-- Información del usuario -->
        <h2>Información del Usuario</h2>
        <p><strong>Nombre:</strong> {{ $usuario->nom }}</p>
        <p><strong>Apellidos:</strong> {{ $usuario->cognoms }}</p>
        
        <!-- Información de la película -->
        <h2>Detalles de la Sesión</h2>
        <p><strong>Película:</strong> {{ $pelicula->titulo }}</p>
        <p><strong>Fila:</strong> {{ $entrada->fila }}</p>
        <p><strong>Columna:</strong> {{ $entrada->columna }}</p>
        <p><strong>Fecha de la Sesión:</strong> {{ $sesion->fecha }}</p>
        
        <p>¡Disfruta de la película!</p>
        <p>Saludos cordiales,</p>
        <p>El equipo de Can Casteller</p>
    </div>
    <div class="footer">
        <p>Este mensaje se ha enviado automáticamente. Por favor, no respondas a este mensaje.</p>
    </div>
</body>
</html>
