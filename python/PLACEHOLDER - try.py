if __name__ == '__main__':
    try:
        main()
        log.info("Script completed successfully")
    except Exception as e:
        log.critical("The script did not complete successfully")
        log.exception(e)
        sys.exit(1)
