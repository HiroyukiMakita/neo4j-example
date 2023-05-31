ARG NEO4J_IMAGE_VERSION
FROM neo4j:${NEO4J_IMAGE_VERSION}

RUN apt-get update -y \
    # コマンド自動化のため expect を追加
    && apt-get install -y expect